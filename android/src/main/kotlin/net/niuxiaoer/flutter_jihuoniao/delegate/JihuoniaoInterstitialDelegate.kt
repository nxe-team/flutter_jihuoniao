package net.niuxiaoer.flutter_jihuoniao.delegate

import com.ads.sdk.api.InterstitialAd.AdListener

class JihuoniaoInterstitialDelegate : AdListener {
    /**
     * 广告展示曝光
     */
    override fun onADExposure() {
        TODO("Not yet implemented")
    }

    /**
     * 广告被点击
     */
    override fun onADClick() {
        TODO("Not yet implemented")
    }

    /**
     * 广告已关闭
     */
    override fun onADClose() {
        TODO("Not yet implemented")
    }

    /**
     * 广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        TODO("Not yet implemented")
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