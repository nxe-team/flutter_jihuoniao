import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_jihuoniao/config/ad_channel.dart';

class FlutterJihuoniao {
  static final MethodChannel _channel =
      MethodChannel(AdChannel.pluginChannelName);

  /// 初始化 SDK
  static Future<void> initSDK(
      {required String appId, required String appKey}) async {
    await _channel.invokeMethod('initSDK', {
      'appId': appId,
      'appKey': appKey,
    });
  }

  /// 显示开屏广告
  static Future<void> showSplashAd({
    required String slotId,
    String? logo,
    Function? onAdRenderSuccess,
    Function? onAdLoadFail,
    Function? onAdDidClick,
    Function? onAdDidClose,
  }) async {
    MethodChannel(AdChannel.splashAdChannelName)
        .setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onAdRenderSuccess':
          onAdRenderSuccess?.call();
          break;
        case 'onAdLoadFail':
          onAdLoadFail?.call();
          break;
        case 'onAdDidClick':
          onAdDidClick?.call();
          break;
        case 'onAdDidClose':
          onAdDidClose?.call();
          break;
      }
    });
    await _channel.invokeMethod('showSplashAd', {
      'slotId': slotId,
      'logo': logo,
    });
  }

  /// 显示插屏广告
  static Future<void> showInterstitialAd({
    required String slotId,
    Function? onAdRenderSuccess,
    Function? onAdLoadFail,
    Function? onAdDidClick,
    Function? onAdDidClose,
  }) async {
    MethodChannel(AdChannel.interstitialAdChannelName)
        .setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onAdRenderSuccess':
          onAdRenderSuccess?.call();
          break;
        case 'onAdLoadFail':
          onAdLoadFail?.call();
          break;
        case 'onAdDidClick':
          onAdDidClick?.call();
          break;
        case 'onAdDidClose':
          onAdDidClose?.call();
          break;
      }
    });
    await _channel.invokeMethod('showInterstitialAd', {
      'slotId': slotId,
    });
  }
}
