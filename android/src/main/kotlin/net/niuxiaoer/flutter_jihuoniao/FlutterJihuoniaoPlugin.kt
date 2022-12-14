package net.niuxiaoer.flutter_jihuoniao

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
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
import net.niuxiaoer.flutter_jihuoniao.util.GlobalData
import net.niuxiaoer.flutter_jihuoniao.view.FeedAdViewFactory
import net.niuxiaoer.flutter_jihuoniao.view.SplashAdActivity

/** FlutterJihuoniaoPlugin */
class FlutterJihuoniaoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var messenger: BinaryMessenger
    private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterBinding = flutterPluginBinding
        context = flutterPluginBinding.applicationContext
        messenger = flutterPluginBinding.binaryMessenger
        GlobalData.messenger = messenger
        channel = MethodChannel(messenger, ChannelNames.pluginChannelName)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val args: Map<String, Any> = call.arguments<Map<String, Any>>() ?: emptyMap()
        when (call.method) {
            "initSDK" -> initSDK(args, result)
            "requestNecessaryPermissions" -> requestNecessaryPermissions(result)
            "showSplashAd" -> showSplashAd(args, result)
            "showInterstitialAd" -> showInterstitialAd(args, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

        // ?????? PlatformView
        flutterBinding.platformViewRegistry.registerViewFactory(
            ChannelNames.feedAdChannelPrefix, FeedAdViewFactory(activity)
        )
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}

    /**
     * ?????????SDK
     */
    private fun initSDK(args: Map<String, Any>, result: Result) {
        val appId: String = args["appId"] as String
        val appKey: String = args["appKey"] as String
        val jiHuoNiaoSDKManager: JiHuoNiaoSDKManager = JiHuoNiaoSDKManager.sharedAds()
        jiHuoNiaoSDKManager.isDebug = args["isDebug"] as Boolean
        jiHuoNiaoSDKManager.startWithAppId(context, appId, appKey)
        result.success(true)
    }

    /**
     * ?????????????????????
     */
    private fun requestNecessaryPermissions(result: Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return
        var necessaryPermissions: Array<String> = emptyArray<String>()

        if (activity.checkSelfPermission(Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            necessaryPermissions += Manifest.permission.READ_PHONE_STATE
        }

        if (activity.checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            necessaryPermissions += Manifest.permission.WRITE_EXTERNAL_STORAGE
        }

        // ????????????
//        if (activity.checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//            necessaryPermissions += Manifest.permission.ACCESS_FINE_LOCATION
//        }

        // ???????????????????????????
        if (necessaryPermissions.isEmpty()) {
            result.success(true);
            return
        }

        activity.requestPermissions(necessaryPermissions, 1)
        result.success(true);
    }

    /**
     * ??????????????????
     */
    private fun showSplashAd(args: Map<String, Any>, result: Result) {
        val splashAd: Intent = Intent(context, SplashAdActivity::class.java)
        splashAd.putExtra("slotId", args["slotId"] as String)
        GlobalData.splashAdResult = result
        activity.startActivity(splashAd)
    }

    /**
     * ??????????????????
     */
    private fun showInterstitialAd(args: Map<String, Any>, result: Result) {
        InterstitialAd().loadAd(
            activity, args["slotId"] as String, JihuoniaoInterstitialDelegate(result)
        )
    }
}
