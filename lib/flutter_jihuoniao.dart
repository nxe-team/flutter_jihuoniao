import 'dart:async';

import 'package:flutter/services.dart';

class FlutterJihuoniao {
  static const MethodChannel _channel = MethodChannel('flutter_jihuoniao');

  /// 初始化 SDK
  static Future<void> initSDK(
      {required String appId, required String appKey}) async {
    await _channel.invokeMethod('initSDK', {
      'appId': appId,
      'appKey': appKey,
    });
  }

  /// 显示开屏广告
  static Future<void> showSplashAd({required String slotId}) async {
    await _channel.invokeMethod('showSplashAd', {
      'slotId': slotId,
    });
  }

  /// 显示插屏广告
  static Future<void> showInterstitialAd({required String slotId}) async {
    await _channel.invokeMethod('showInterstitialAd', {
      'slotId': slotId,
    });
  }
}
