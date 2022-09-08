//
//  FlutterJihuoniaoChannel.swift
//  flutter_jihuoniao
//
//  Created by Anand on 2022/8/23.
//

class FlutterJihuoniaoChannel: NSObject {
    /// 插件消息通道
    static let pluginChannelName = "flutter_jihuoniao"
    
    /// 开屏广告消息通道
    static let splashAdChannelName = "flutter_jihuoniao_splash_ad"
    
    /// 插屏广告消息通道
    static let interstitialAdChannelName = "flutter_jihuoniao_interstitial_ad"
    
    /// 信息流广告 PlatformView
    static let feedAdChannelPrefix = "flutter_jihuoniao_feed_ad"
}
