
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterJihuoniao {
  static const MethodChannel _channel = MethodChannel('flutter_jihuoniao');

  /// 初始化 SDK
  static Future<void> initSDK() async {
    await _channel.invokeMethod('initSDK');
  }
}
