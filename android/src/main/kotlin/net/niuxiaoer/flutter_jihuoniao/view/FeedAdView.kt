package net.niuxiaoer.flutter_jihuoniao.view

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.util.DisplayMetrics
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import com.ads.sdk.api.FeedAd.AdListener
import com.ads.sdk.api.FeedData
import com.ads.sdk.api.JHNFeedAd
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData

class FeedAdViewFactory(private var activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String, Any>? ?: emptyMap()
        return FeedAdView(context, activity, viewId, creationParams)
    }
}

class FeedAdView(
    private val context: Context, activity: Activity, viewId: Int, args: Map<String, Any>
) : PlatformView, AdListener {
    private var channel: MethodChannel
    private var container: FrameLayout = FrameLayout(context)
    private val displayMetrics: DisplayMetrics

    override fun getView(): View {
        return container
    }

    override fun dispose() {}

    init {
        // 广告容器
        container.layoutParams = FrameLayout.LayoutParams(
            // 宽度和父容器相同
            ViewGroup.LayoutParams.WRAP_CONTENT,
            // 高度能包裹广告视图
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        container.setBackgroundColor(Color.WHITE)
        displayMetrics = context.applicationContext.resources.displayMetrics

        val jhnFeedAd: JHNFeedAd = JHNFeedAd()
        val screenWidth: Int = (displayMetrics.widthPixels / displayMetrics.density).toInt()
        jhnFeedAd.dpWidth = screenWidth
        jhnFeedAd.isVideoSound = false
        jhnFeedAd.adCount = 1
        jhnFeedAd.loadAd(activity, args["slotId"] as String, this)
        channel =
            MethodChannel(GlobalData.messenger, "${ChannelNames.feedAdChannelPrefix}/${viewId}")
    }

    /**
     * 传递消息给 Flutter
     */
    private fun postMessage(method: String, arguments: Map<String, Any>?) {
        Log.d("###", method)
        channel.invokeMethod(method, arguments)
    }

    /**
     * 信息流广告渲染成功
     */
    override fun onRenderSuccess(p0: FeedData?) {
        if (p0 == null) return

        p0.views.measure(View.MeasureSpec.UNSPECIFIED, View.MeasureSpec.UNSPECIFIED)
        Log.d("###", "onRenderSuccess ${p0.views.height} ${p0.views.measuredHeight}")

        val adViewHeight: Double = (p0.views.height / displayMetrics.density).toDouble()

        // 传递高度给Flutter
        postMessage("onAdRenderSuccess", mapOf("height" to adViewHeight))
    }

    /**
     * 信息流广告加载成功
     */
    override fun onADLoaded(p0: MutableList<FeedData>?) {
        if (p0 == null) return

        Log.d("###", "${p0.size}")
        val feedAd: FeedData = p0.first()
        feedAd.render()
        container.addView(feedAd.views)
        // TODO: 快手广告测量后高度不对
        // container.viewTreeObserver.addOnGlobalLayoutListener()
    }

    /**
     * 信息流广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        Log.d("###", "FeedAd onAdLoadFail $p2")
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