package net.niuxiaoer.flutter_jihuoniao.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.FrameLayout
import com.ads.sdk.api.SplashAd
import net.niuxiaoer.flutter_jihuoniao.R

class SplashAdActivity : AppCompatActivity() {
    private lateinit var container: FrameLayout
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash_ad)

        container = findViewById(R.id.splash_ad_container)
        loadAd()
    }

    private fun loadAd() {
        SplashAd().loadAd(this, container, "81q547sonhiw", object : SplashAd.AdListener {
            override fun onADClose() {
                Log.d("###", "onADClose")
            }

            override fun onADClick() {
                Log.d("###", "onADClick")
            }

            override fun onADExposure() {
                Log.d("###", "onADExposure")
            }

            override fun onADLoaded() {
                Log.d("###", "onADLoaded")
            }

            override fun onADError(p0: Int, p1: String?, p2: String?) {
                Log.d("###", "onADError")
            }
        })
    }
}