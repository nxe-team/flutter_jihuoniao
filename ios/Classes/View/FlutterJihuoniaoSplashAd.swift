//
//  FlutterJihuoniaoSplashAd.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/8/24.
//

import JiHuoNiaoAdSDK
import UIKit

class FlutterJihuoniaoSplashAd: NSObject, JHNSplashAdDelegate {
    private let result: FlutterResult
    private let methodChannel: FlutterMethodChannel
    private let splashAd: JHNSplashAd
    
    init(args: [String: Any], result: @escaping FlutterResult, messenger: FlutterBinaryMessenger) {
        self.result = result
        methodChannel = FlutterMethodChannel(
            name: FlutterJihuoniaoChannel.splashAdChannelName,
            binaryMessenger: messenger)
        splashAd = JHNSplashAd(slotID: args["slotId"] as! String)
        super.init()
        splashAd.delegate = self
        // 设置底部 logo
        let logo: String = args["logo"] as? String ?? ""
        if !logo.isEmpty, let logoView: UIView = generateLogoView(logo) {
            splashAd.setLogoBottom(logoView)
        }
        splashAd.load()
    }
    
    /// 制作 logo 视图
    func generateLogoView(_ name: String) -> UIView? {
        let logoImage: UIImage? = UIImage(named: name)
        // 图片不存在
        if logoImage == nil {
            return nil
        }
        let logoImageView: UIView = UIImageView(image: logoImage)
        // 容器
        let screenSize: CGSize = UIScreen.main.bounds.size
        let logoContainerFrame: CGRect = CGRect(
            x: 0,
            y: 0,
            width: screenSize.width,
            // 推荐开屏 Logo 高度占比
            height: screenSize.height * 0.15)
        let logoContainer: UIView = UIView(frame: logoContainerFrame)
        logoContainer.backgroundColor = UIColor.white
        // 居中
        logoImageView.contentMode = UIView.ContentMode.center
        logoImageView.center = logoContainer.center
        // 添加 logo
        logoContainer.addSubview(logoImageView)
        return logoContainer
    }
    
    /// 传递消息给 Flutter 端
    private func postMessage(_ method: String, arguments: [String: Any]? = nil) {
        methodChannel.invokeMethod(method, arguments: arguments)
    }
    
    /// 开屏广告渲染成功
    func jhnSplashViewRenderSuccess() {
        postMessage("onAdRenderSuccess")
    }
    
    /// 开屏广告加载失败
    func jhnSplashViewFailWithError(_ error: Error) {
        postMessage("onAdLoadFail")
        result(false)
    }
    
    /// 开屏广告被点击
    func jhnSplashViewDidClick() {
        postMessage("onAdDidClick")
    }
    
    /// 开屏广告已关闭
    func jhnSplashViewDidClose() {
        postMessage("onAdDidClose")
        result(true)
    }
}
