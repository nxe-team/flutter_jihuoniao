import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jihuoniao/config/ad_channel.dart';

class FlutterJihuoniao {
  static final MethodChannel _channel =
      MethodChannel(AdChannel.pluginChannelName);

  /// 初始化 SDK
  static Future<void> initSDK({
    required String appId,
    required String appKey,
    bool isDebug = true,
  }) async {
    await _channel.invokeMethod('initSDK', {
      'appId': appId,
      'appKey': appKey,
      'isDebug': isDebug,
    });
  }

  /// 请求必要的权限
  static Future<void> requestNecessaryPermissions() async {
    if (Platform.isIOS) return;
    await _channel.invokeMethod('requestNecessaryPermissions');
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
    required BuildContext context,
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
          // 关闭空白弹窗
          if (Platform.isIOS) Navigator.pop(context);
          onAdLoadFail?.call();
          break;
        case 'onAdDidClick':
          onAdDidClick?.call();
          break;
        case 'onAdDidClose':
          // 关闭空白弹窗
          if (Platform.isIOS) Navigator.pop(context);
          onAdDidClose?.call();
          break;
      }
    });

    // 显示一个空白弹窗用于阻止部分广告素材存在的事件穿透
    // QUE: 展示的广告并不在顶层？
    // 考虑放在iOS里添加空白视图，Delegate 回调中
    //   没有广告的 UIVIew 供调用 bringSubviewToFront
    if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: const Material(color: Colors.transparent),
        ),
      );
    }

    await _channel.invokeMethod('showInterstitialAd', {
      'slotId': slotId,
    });
  }
}
