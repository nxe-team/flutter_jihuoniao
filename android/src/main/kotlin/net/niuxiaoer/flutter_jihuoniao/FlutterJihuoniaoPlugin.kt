package net.niuxiaoer.flutter_jihuoniao

import android.app.Activity
import android.content.Context
import android.content.Intent
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
import net.niuxiaoer.flutter_jihuoniao.config.ChannelNames
import net.niuxiaoer.flutter_jihuoniao.delegate.JihuoniaoInterstitialDelegate
import net.niuxiaoer.flutter_jihuoniao.view.SplashAdActivity

/** FlutterJihuoniaoPlugin */
class FlutterJihuoniaoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var messenger: BinaryMessenger

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        messenger = flutterPluginBinding.binaryMessenger
        channel = MethodChannel(messenger, ChannelNames.pluginChannelName)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initSDK" -> initSDK(result)
            "showSplashAd" -> showSplashAd(result)
            "showInterstitialAd" -> showInterstitialAd(result)
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

    /**
     * 初始化SDK
     */
    private fun initSDK(result: Result) {
        val jiHuoNiaoSDKManager: JiHuoNiaoSDKManager = JiHuoNiaoSDKManager.sharedAds()
        jiHuoNiaoSDKManager.setDebug(true)
        jiHuoNiaoSDKManager.startWithAppId(context, "836543846000", "02d1213c2f12372f")
        result.success(true)
    }

    /**
     * 显示开屏广告
     */
    private fun showSplashAd(result: Result) {
        activity.startActivity(Intent(context, SplashAdActivity::class.java))
        result.success(true)
    }

    /**
     * 显示插屏广告
     */
    private fun showInterstitialAd(result: Result) {
        InterstitialAd().loadAd(
            activity,
            "81q61bh65ujq",
            JihuoniaoInterstitialDelegate()
        )
        result.success(true)
    }
}
