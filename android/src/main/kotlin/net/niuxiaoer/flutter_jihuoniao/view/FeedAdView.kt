package net.niuxiaoer.flutter_jihuoniao.view

import android.app.Activity
import android.content.Context
import android.util.DisplayMetrics
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.LinearLayout
import com.ads.sdk.api.FeedAd.AdListener
import com.ads.sdk.api.FeedData
import com.ads.sdk.api.JHNFeedAd
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData
import kotlin.math.max

class FeedAdViewFactory(private var activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String, Any>? ?: emptyMap()
        return FeedAdView(context, activity, viewId, creationParams)
    }
}

class FeedAdView(
    context: Context, activity: Activity, viewId: Int, args: Map<String, Any>
) : PlatformView, AdListener {
    private var channel: MethodChannel
    private var container: LinearLayout = LinearLayout(context)
    private val displayMetrics: DisplayMetrics

    override fun getView(): View {
        return container
    }

    override fun dispose() {}

    init {
        // 广告容器
        container.layoutParams = FrameLayout.LayoutParams(
            // 宽度和父容器相同
            ViewGroup.LayoutParams.MATCH_PARENT,
            // 高度能包裹广告视图
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        displayMetrics = context.applicationContext.resources.displayMetrics

        val jhnFeedAd: JHNFeedAd = JHNFeedAd()
        val screenWidth: Int = (displayMetrics.widthPixels / displayMetrics.density).toInt()
        jhnFeedAd.setDpWidth(screenWidth)
        jhnFeedAd.setVideoSound(false)
        jhnFeedAd.loadAd(activity, args["slotId"] as String, this)
        channel =
            MethodChannel(GlobalData.messenger, "${ChannelNames.feedAdChannelPrefix}/${viewId}")
    }

    /**
     * 传递消息给 Flutter
     */
    private fun postMessage(method: String, arguments: Map<String, Any>?) {
        channel.invokeMethod(method, arguments)
    }

    /**
     * 信息流广告加载成功
     */
    override fun onADLoaded(p0: MutableList<FeedData>?) {
        if (p0 == null) {
            return
        }

        val feedAd: FeedData = p0.first()
        feedAd.render()
        container.addView(feedAd.views)
        container.measure(0, 0)

        // TODO: 快手广告测量后高度不对
        val adViewHeight: Double = max(
            200.0, (container.measuredHeight / displayMetrics.density).toDouble()
        )
        postMessage("onAdRenderSuccess", mapOf("height" to adViewHeight))
    }

    /**
     * 信息流广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        postMessage("onAdLoadFail", null)
    }

    /**
     * 信息流广告曝光展示
     */
    override fun onADExposure() {
        postMessage("onAdViewExposure", null)
    }

    /**
     * 信息流广告被点击
     */
    override fun onADClick() {
        postMessage("onAdDidClick", null)
    }

    /**
     * 信息流广告已关闭
     */
    override fun onADClose(p0: FeedData?) {
        postMessage("onAdDidClose", null)
        // TODO: 销毁广告
        container.removeAllViews()
    }
}