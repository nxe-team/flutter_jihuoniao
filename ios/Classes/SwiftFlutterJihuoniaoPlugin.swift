import Flutter
import UIKit
import JiHuoNiaoAdSDK

public class SwiftFlutterJihuoniaoPlugin: NSObject, FlutterPlugin {
    private static var messenger: FlutterBinaryMessenger?
    private var interstitialAd: FlutterJihuoniaoInterstitialAd?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        messenger = registrar.messenger()
        let channel = FlutterMethodChannel(
            name: FlutterJihuoniaoChannel.pluginChannelName,
            binaryMessenger: messenger!)
        let instance = SwiftFlutterJihuoniaoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
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
            result(true)
        case "showInterstitialAd":
            interstitialAd = FlutterJihuoniaoInterstitialAd(
                args: args,
                messenger: SwiftFlutterJihuoniaoPlugin.messenger!)
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
