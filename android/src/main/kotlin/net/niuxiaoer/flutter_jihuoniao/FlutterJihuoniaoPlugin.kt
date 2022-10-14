package net.niuxiaoer.flutter_jihuoniao

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.ads.sdk.api.InterstitialAd
import com.jihuoniao.sdk.JiHuoNiaoSDKManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import net.niuxiaoer.flutter_jihuoniao.view.SplashAdActivity

/** FlutterJihuoniaoPlugin */
class FlutterJihuoniaoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_jihuoniao")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initSDK" -> {
                val jiHuoNiaoSDKManager: JiHuoNiaoSDKManager = JiHuoNiaoSDKManager.sharedAds()
                jiHuoNiaoSDKManager.setDebug(true)
                jiHuoNiaoSDKManager.startWithAppId(context, "836543846000", "02d1213c2f12372f")
                result.success(true)
            }
            "showSplashAd" -> {
                activity.startActivity(Intent(context, SplashAdActivity::class.java))
                result.success(true)
            }
            "showInterstitialAd" -> {
                InterstitialAd().loadAd(
                    activity,
                    "81q61bh65ujq",
                    object : InterstitialAd.AdListener {
                        override fun onADCached() {
                            Log.d("###", "onADCached")
                        }

                        override fun onADOpen() {
                            Log.d("###", "onADOpen")
                        }

                        override fun onADExposure() {
                            Log.d("###", "onADExposure")
                        }

                        override fun onADClick() {
                            Log.d("###", "onAdDidClick")
                        }

                        override fun onADClose() {
                            Log.d("###", "onAdDidClose")
                        }

                        override fun onADError(p0: Int, p1: String?, p2: String?) {
                            Log.d("###", "onADError")
                        }
                    })
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}
