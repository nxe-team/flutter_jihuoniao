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
    private let feedAd: JHNFeedAd
    private let adView: UIView
    
    func view() -> UIView {
        adView
    }
    
    init(frame: CGRect, id: Int64, args: [String: Any], messenger: FlutterBinaryMessenger) {
        adView = UIView(frame: frame)
        feedAd = JHNFeedAd(
            slotID: args["slotId"] as! String,
            size: CGSize(width: UIScreen.main.bounds.width, height: 0))
        super.init()
        feedAd.delegate = self
        feedAd.videoMuted = true
        feedAd.load(withCount: 1)
    }
    
    /// 信息流广告加载成功
    func jhnFeedAdDidLoad(_ feedDataArray: [Any]) {
        print("jhnFeedAdDidLoad");
        adView.addSubview(feedDataArray.first as! UIView)
    }
    
    /// 信息流广告加载失败
    func jhnFeedAdFail(withCode code: Int, tipStr: String, errorMessage: String) {
        print("jhnFeedAdFail");
    }
    
    /// 信息流广告渲染成功
    func jhnFeedAdViewRenderSuccess() {
        print("jhnFeedAdViewRenderSuccess");
    }
    
    /// 信息流广告已展示
    func jhnFeedAdViewExposure() {
        print("jhnFeedAdViewExposure");
    }
    
    /// 信息流广告被点击
    func jhnFeedAdDidClick() {
        print("jhnFeedAdDidClick");
    }
    
    /// 信息流广告已关闭
    func jhnFeedAdDidClose(_ feedAd: Any) {
        print("jhnFeedAdDidClose");
    }
}
