package net.niuxiaoer.flutter_jihuoniao.view

import android.os.Bundle
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import com.ads.sdk.api.SplashAd
import net.niuxiaoer.flutter_jihuoniao.R

class SplashAdActivity : AppCompatActivity(), SplashAd.AdListener {
    private lateinit var container: FrameLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash_ad)
        // 设置该活动渐入渐出
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)

        container = findViewById(R.id.splash_ad_container)
        // 加载广告
        SplashAd().loadAd(this, container, "81q547sonhiw", this)
    }

    /**
     * 广告已关闭
     */
    override fun onADClose() {
        TODO("Not yet implemented")
    }

    /**
     * 广告被点击
     */
    override fun onADClick() {
        TODO("Not yet implemented")
    }

    /**
     * 广告曝光展示
     */
    override fun onADExposure() {
        TODO("Not yet implemented")
    }

    /**
     * 广告加载完成
     */
    override fun onADLoaded() {
        TODO("Not yet implemented")
    }

    /**
     * 广告加载失败
     */
    override fun onADError(p0: Int, p1: String?, p2: String?) {
        TODO("Not yet implemented")
    }
}