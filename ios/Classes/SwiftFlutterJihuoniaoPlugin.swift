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
        let args = call.arguments as? [String: Any] ?? [:]
        switch call.method {
        case "initSDK":
            JiHuoNiaoSDKManager.start(withAppid: "836791510808", appKey: "36f6746399497b45")
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
