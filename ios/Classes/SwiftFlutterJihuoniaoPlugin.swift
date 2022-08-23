import Flutter
import UIKit
import JiHuoNiaoAdSDK

public class SwiftFlutterJihuoniaoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_jihuoniao", binaryMessenger: registrar.messenger())
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
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
