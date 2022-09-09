import Flutter
import UIKit
import JiHuoNiaoAdSDK

public class SwiftFlutterJihuoniaoPlugin: NSObject, FlutterPlugin {
    private static var messenger: FlutterBinaryMessenger?
    private var splashAd: FlutterJihuoniaoSplashAd?
    private var interstitialAd: FlutterJihuoniaoInterstitialAd?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        messenger = registrar.messenger()
        let channel = FlutterMethodChannel(
            name: FlutterJihuoniaoChannel.pluginChannelName,
            binaryMessenger: messenger!)
        let instance = SwiftFlutterJihuoniaoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        // 注册信息流广告 PlatformView
        registrar.register(
            FlutterJihuoniaoFeedAdFactory(messenger: messenger!),
            withId: FlutterJihuoniaoChannel.feedAdChannelPrefix)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args: [String: Any] = call.arguments as? [String: Any] ?? [:]
        switch call.method {
        case "initSDK":
            JiHuoNiaoSDKManager.start(
                withAppid: args["appId"] as! String,
                appKey: args["appKey"] as! String)
            result(true)
        case "showSplashAd":
            splashAd = FlutterJihuoniaoSplashAd(
                args: args,
                result: result,
                messenger: SwiftFlutterJihuoniaoPlugin.messenger!)
        case "showInterstitialAd":
            interstitialAd = FlutterJihuoniaoInterstitialAd(
                args: args,
                result: result,
                messenger: SwiftFlutterJihuoniaoPlugin.messenger!)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
