//
//  FlutterJihuoniaoSplashAd.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/8/24.
//

import JiHuoNiaoAdSDK

class FlutterJihuoniaoSplashAd: NSObject, JHNSplashAdDelegate {
    private let methodChannel: FlutterMethodChannel
    private let splashAd: JHNSplashAd
    
    init(args: [String: Any], messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
                    name: FlutterJihuoniaoChannel.splashAdChannelName,
                    binaryMessenger: messenger)
        splashAd = JHNSplashAd(slotID: args["slotId"] as! String)
        super.init()
        splashAd.delegate = self
        splashAd.load()
    }
    
    private func postMessage(_ method: String, arguments: [String: Any]? = nil) {
        methodChannel.invokeMethod(method, arguments: arguments)
    }
    
    /// 开屏广告渲染成功
    func jhnSplashViewRenderSuccess() {
        postMessage("onAdRenderSuccess")
        print("jhnSplashViewRenderSuccess")
    }
    
    /// 开屏广告加载失败
    func jhnSplashViewFailWithError(_ error: Error) {
        postMessage("onAdDidClose")
        print("jhnSplashViewFailWithError")
    }
    
    /// 开屏广告被点击
    func jhnSplashViewDidClick() {
        postMessage("onAdDidClick")
        print("jhnSplashViewDidClick")
    }
    
    /// 开屏广告已关闭
    func jhnSplashViewDidClose() {
        postMessage("onAdDidClose")
        print("jhnSplashViewDidClose")
    }
}
