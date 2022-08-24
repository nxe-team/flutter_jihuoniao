//
//  FlutterJihuoniaoSplashAd.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/8/24.
//

import JiHuoNiaoAdSDK
import UIKit

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
        // 设置底部 logo
        let logo: String = args["logo"] as? String ?? ""
        if !logo.isEmpty {
            splashAd.setLogoBottom(generateLogoView(logo))
        }
        splashAd.load()
    }
    
    /// 制作 logo 视图
    func generateLogoView(_ name: String) -> UIView {
        // logo 图
        let logoImage: UIView = UIImageView(image: UIImage(named: name))
        // 容器
        let screenSize: CGSize = UIScreen.main.bounds.size
        let logoContainerWidth: CGFloat = screenSize.width
        let logoContainerHeight: CGFloat = screenSize.height * 0.15
        let logoContainer: UIView = UIView(frame: CGRect(x: 0, y: 0, width: logoContainerWidth, height: logoContainerHeight))
        logoContainer.backgroundColor = UIColor.white
        // 居中
        logoImage.contentMode = UIView.ContentMode.center
        logoImage.center = logoContainer.center
        // 添加 logo
        logoContainer.addSubview(logoImage)
        return logoContainer
    }
    
    /// 传递消息给 Flutter 端
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
