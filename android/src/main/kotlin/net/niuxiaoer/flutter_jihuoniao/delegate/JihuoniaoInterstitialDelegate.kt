package net.niuxiaoer.flutter_jihuoniao.delegate

import android.util.Log
import com.ads.sdk.api.InterstitialAd.AdListener
import io.flutter.plugin.common.MethodChannel
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData

class JihuoniaoInterstitialDelegate(
    private val result: MethodChannel.Result,
    private val channel: MethodChannel = MethodChannel(
        GlobalData.messenger,
        ChannelNames.interstitialAdChannelName
    )
) : AdListener {
    /**
     * 已经提交结果给 Flutter 端，防止重复调用 result
     */
    private var isReturned: Boolean = false

    private fun postMessage(method: String, arguments: Map<String, Any>?) {
        channel.invokeMethod(method, arguments)
    }

    /**
     * 广告展示曝光
     */
    override fun onADExposure() {
        postMessage("onAdRenderSuccess", null)
    }

    /**
     * 广告被点击
     */
    override fun onADClick() {
        postMessage("onAdDidClick", null)
    }

    /**
     * 广告已关闭
     */
    override fun onADClose() {
        if (isReturned) return
        postMessage("onAdDidClose", null)
        result.success(true)
        isReturned = true
    }

    /**
     * 广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        if (isReturned) return
        postMessage("onAdLoadFail", null)
        result.success(false)
        isReturned = true
    }

    /**
     * 激活鸟: 针对指定预算的回调
     */
    override fun onADCached() {}

    /**
     * 激活鸟: 针对指定预算的回调
     */
    override fun onADOpen() {}
}