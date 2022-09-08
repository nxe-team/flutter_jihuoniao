//
//  FlutterJihuoniaoFeedAd.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/9/7.
//

import Flutter
import JiHuoNiaoAdSDK

class FlutterJihuoniaoFeedAdFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        FlutterJihuoniaoFeedAd(frame: frame, id: viewId, args: args as! [String : Any], messenger: messenger)
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
}

class FlutterJihuoniaoFeedAd: NSObject, FlutterPlatformView, JHNFeedAdDelegate {
    private let methodChannel: FlutterMethodChannel
    private let feedAd: JHNFeedAd
    private let container: UIView
    
    func view() -> UIView {
        container
    }
    
    init(frame: CGRect, id: Int64, args: [String: Any], messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
            name: "\(FlutterJihuoniaoChannel.feedAdChannelPrefix)/\(id)",
            binaryMessenger: messenger)
        container = UIView(frame: frame)
        feedAd = JHNFeedAd(
            slotID: args["slotId"] as! String,
            size: CGSize(width: UIScreen.main.bounds.width, height: 0))
        super.init()
        feedAd.delegate = self
        feedAd.videoMuted = true
        feedAd.load(withCount: 1)
    }
    
    /// 传递消息给 Flutter 端
    private func postMessage(_ method: String, arguments: [String: Any]? = nil) {
        methodChannel.invokeMethod(method, arguments: arguments)
    }
    
    /// 信息流广告加载成功
    func jhnFeedAdDidLoad(_ feedDataArray: [Any]) {
        container.addSubview(feedDataArray.first as! UIView)
    }
    
    /// 信息流广告加载失败
    func jhnFeedAdFail(withCode code: Int, tipStr: String, errorMessage: String) {
        postMessage("onAdLoadFail", arguments: [
            "message": "\(code); \(tipStr); \(errorMessage)",
        ])
    }
    
    /// 信息流广告渲染成功
    func jhnFeedAdViewRenderSuccess() {
        if let adView: UIView = container.subviews.first {
            postMessage("onAdRenderSuccess", arguments: [
                "height": adView.bounds.height
            ])
        }
    }
    
    /// 信息流广告已展示
    func jhnFeedAdViewExposure() {
        postMessage("onAdViewExposure")
    }
    
    /// 信息流广告被点击
    func jhnFeedAdDidClick() {
        postMessage("onAdDidClick")
    }
    
    /// 信息流广告已关闭
    func jhnFeedAdDidClose(_ feedAd: Any) {
        postMessage("onAdDidClose")
    }
}
