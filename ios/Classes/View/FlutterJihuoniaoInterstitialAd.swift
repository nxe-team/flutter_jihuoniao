//
//  FlutterJihuoniaoInterstitialAd.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/8/23.
//

import JiHuoNiaoAdSDK

class FlutterJihuoniaoInterstitialAd: NSObject, JHNInterstitialAdDelegate {
    private let result: FlutterResult
    private let methodChannel: FlutterMethodChannel
    private let interstitialAd: JHNInterstitialAd
    
    init(args: [String: Any], result: @escaping FlutterResult, messenger: FlutterBinaryMessenger) {
        self.result = result
        methodChannel = FlutterMethodChannel(
                    name: FlutterJihuoniaoChannel.interstitialAdChannelName,
                    binaryMessenger: messenger)
        interstitialAd = JHNInterstitialAd(slotID: args["slotId"] as! String)
        super.init()
        interstitialAd.delegate = self
        interstitialAd.load()
    }
    
    private func postMessage(_ method: String, arguments: [String: Any]? = nil) {
        methodChannel.invokeMethod(method, arguments: arguments)
    }
    
    /// 插屏广告渲染成功
    func jhnInterstitialAdRenderSuccess() {
        postMessage("onAdRenderSuccess")
    }
    
    /// 插屏广告加载失败
    func jhnInterstitialAdFailWithError(_ error: Error?) {
        postMessage("onAdLoadFail")
        result(false)
    }
    
    /// 插屏广告被点击
    func jhnInterstitialAdDidClick() {
        postMessage("onAdDidClick")
    }
    
    /// 插屏广告已关闭
    func jhnInterstitialAdDidClose() {
        postMessage("onAdDidClose")
        result(true)
    }
}
