package net.niuxiaoer.flutter_jihuoniao.util

import android.app.Activity
import android.util.Log
import com.ads.sdk.api.FeedAd.AdListener
import com.ads.sdk.api.FeedData
import com.ads.sdk.api.JHNFeedAd

interface FeedCallback {
    fun onAdDidLoad(feedAd: FeedData)
    fun onAdRenderSuccess(feedAd: FeedData)
    fun onAdDidClose()
}

class FeedAdItem(
    var feedAd: FeedData?, val callback: FeedCallback
)

object FeedAdManager : AdListener {
    private val jhnFeedAd: JHNFeedAd = JHNFeedAd()

    /**
     * 缓存的广告数据
     */
    private val cachedAds: ArrayList<FeedData> = ArrayList()
        @Synchronized get

    /**
     * 创建 PlatformView 后使用的回调和数据
     */
    private val feedItems: ArrayList<FeedAdItem> = ArrayList()
        @Synchronized get

    @Synchronized
    fun loadFeed(
        activity: Activity, slotId: String, dpWidth: Int, callback: FeedCallback
    ) {
        // 没有缓存 -> 调用加载
        if (cachedAds.isEmpty()) {
            jhnFeedAd.dpWidth = dpWidth
            jhnFeedAd.isVideoSound = false
            // 大部分广告都建议不要超过3
            jhnFeedAd.adCount = 3
            // 加载成功后的数据不一定是3
            jhnFeedAd.loadAd(activity, slotId, this)
            // 加载成功后再替换null
            feedItems.add(FeedAdItem(null, callback))
            return
        }
        // 有缓存 -> 使用并回调加载成功
        val feedAd: FeedData = cachedAds.removeFirst()
        callback.onAdDidLoad(feedAd)
        feedItems.add(FeedAdItem(feedAd, callback))
    }

    /**
     * 销毁广告
     */
    fun destroyAd(feedAd: FeedData?) {
        if (feedAd == null) return

        // 找出来触发回调
        for (feed in feedItems) {
            if (feed.feedAd == feedAd) {
                feed.callback.onAdDidClose()
                // 销毁广告
                feed.feedAd?.onDestroy()
                feedItems.remove(feed)
                break
            }
        }
    }

    /**
     * 信息流广告加载成功
     */
    override fun onADLoaded(p0: MutableList<FeedData>?) {
        if (p0 == null) return

        val loadAds: ArrayList<FeedData> = ArrayList(p0)
        // 从后往前添加广告数据 利于曝光
        for (feed in feedItems.reversed()) {
            // 这次加载的用光了
            if (loadAds.isEmpty()) break
            // 已经有数据了
            if (feed.feedAd != null) continue

            val feedData: FeedData = loadAds.removeFirst()
            feed.feedAd = feedData
            feed.callback.onAdDidLoad(feedData)
        }
        // 剩下的放入缓存
        cachedAds.addAll(loadAds)
    }

    /**
     * 信息流广告渲染成功
     */
    override fun onRenderSuccess(p0: FeedData?) {
        if (p0 == null) return
        // 找出来触发回调
        for (feed in feedItems) {
            if (feed.feedAd == p0) {
                feed.callback.onAdRenderSuccess(p0)
                break
            }
        }
    }

    /**
     * 信息流广告加载/曝光失败
     * 不明确哪一个广告被点击了，暂不使用
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        Log.d("FeedAdManager", "$p0 $p1 $p2")
    }

    /**
     * 信息流广告已关闭
     */
    override fun onADClose(p0: FeedData?) {
        if (p0 == null) return
        destroyAd(p0)
    }

    /**
     * 信息流广告被点击
     * 不明确哪一个广告被点击了，暂不使用
     */
    override fun onADClick() {}

    /**
     * 信息流广告曝光展示
     * 不明确哪一个广告被曝光了，暂不使用
     */
    override fun onADExposure() {}
}
