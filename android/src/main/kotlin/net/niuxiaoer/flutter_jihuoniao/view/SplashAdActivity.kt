package net.niuxiaoer.flutter_jihuoniao.view

import android.os.Bundle
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import com.ads.sdk.api.SplashAd
import io.flutter.plugin.common.MethodChannel
import net.niuxiaoer.flutter_jihuoniao.R
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData

class SplashAdActivity : AppCompatActivity(), SplashAd.AdListener {
    private lateinit var container: FrameLayout
    private lateinit var channel: MethodChannel

    /**
     * 已经提交结果给 Flutter 端，防止重复调用 result
     */
    private var isReturned: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash_ad)
        // 设置该活动渐入渐出
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)

        container = findViewById(R.id.splash_ad_container)
        channel = MethodChannel(GlobalData.messenger, ChannelNames.splashAdChannelName)
        // 加载广告
        SplashAd().loadAd(this, container, intent.getStringExtra("slotId"), this)
    }

    /**
     * 传递消息给 Flutter
     */
    private fun postMessage(method: String, arguments: Map<String, Any>?) {
        channel.invokeMethod(method, arguments)
    }

    /**
     * 广告关闭，会被多次调用
     */
    override fun onADClose() {
        finish()
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)

        if (isReturned) return
        postMessage("onAdDidClose", null)
        GlobalData.splashAdResult.success(true)
        isReturned = true
    }

    /**
     * 广告被点击
     */
    override fun onADClick() {
        postMessage("onAdDidClick", null)
    }

    /**
     * 广告曝光展示
     */
    override fun onADExposure() {}

    /**
     * 广告加载完成
     */
    override fun onADLoaded() {}

    /**
     * 广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        if (isReturned) return
        postMessage("onAdLoadFail", null)
        GlobalData.splashAdResult.success(false)
        isReturned = true
    }
}