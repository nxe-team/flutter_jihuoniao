package net.niuxiaoer.flutter_jihuoniao.view

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.util.DisplayMetrics
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.ads.sdk.api.FeedAd.AdListener
import com.ads.sdk.api.FeedData
import com.ads.sdk.api.JHNFeedAd
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.util.FeedAdManager
import net.niuxiaoer.flutter_jihuoniao.util.FeedCallback
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData

class FeedAdViewFactory(private var activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String, Any>? ?: emptyMap()
        return FeedAdView(context, activity, viewId, creationParams)
    }
}

class FeedAdView(
    context: Context, activity: Activity, viewId: Int, args: Map<String, Any>
) : PlatformView, FeedCallback {
    private var channel: MethodChannel
    private var container: LinearLayout = LinearLayout(context)
    private val displayMetrics: DisplayMetrics
    private var feedAd: FeedData? = null

    override fun getView(): View {
        return container
    }

    override fun dispose() {
        FeedAdManager.destroyAd(feedAd)
        container.removeAllViews()
    }

    init {
        // 广告容器
        container.layoutParams = LinearLayout.LayoutParams(
            // 宽度和父容器相同
            ViewGroup.LayoutParams.WRAP_CONTENT,
            // 高度能包裹广告视图
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        container.clipChildren = false
        container.setBackgroundColor(Color.WHITE)
        displayMetrics = context.applicationContext.resources.displayMetrics
        val screenWidth: Int = (displayMetrics.widthPixels / displayMetrics.density).toInt()
        FeedAdManager.loadFeed(activity, args["slotId"] as String, screenWidth, this)
        channel =
            MethodChannel(GlobalData.messenger, "${ChannelNames.feedAdChannelPrefix}/${viewId}")
    }

    /**
     * 传递消息给 Flutter
     */
    private fun postMessage(method: String, arguments: Map<String, Any>?) {
//        Log.d("###", method)
        channel.invokeMethod(method, arguments)
    }

    /**
     * 信息流广告渲染成功
     */
    override fun onAdRenderSuccess(feedAd: FeedData) {
        this.feedAd = feedAd
        val adViewHeight: Double = (feedAd.views.height / displayMetrics.density).toDouble()
        postMessage("onAdRenderSuccess", mapOf("height" to adViewHeight))
    }

    /**
     * 信息流广告加载成功
     */
    override fun onAdDidLoad(feedAd: FeedData) {
        feedAd.render()
        container.addView(feedAd.views)
    }

    /**
     * 信息流广告已关闭
     */
    override fun onAdDidClose() {
        postMessage("onAdDidClose", null)
        container.removeAllViews()
    }
}