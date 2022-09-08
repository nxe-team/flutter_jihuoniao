import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JihuoniaoFeedAd extends StatefulWidget {
  static const String viewType = 'flutter_jihuoniao_feed_ad';

  /// 广告位 ID
  final String slotId;

  /// 广告渲染成功
  final Function? onAdRenderSuccess;

  /// 广告加载失败
  final void Function(String message)? onAdLoadFail;

  /// 广告被曝光
  final Function? onAdViewExposure;

  /// 广告被点击
  final Function? onAdDidClick;

  /// 广告已广告
  final Function? onAdDidClose;

  const JihuoniaoFeedAd({
    Key? key,
    required this.slotId,
    this.onAdRenderSuccess,
    this.onAdLoadFail,
    this.onAdViewExposure,
    this.onAdDidClick,
    this.onAdDidClose,
  }) : super(key: key);

  @override
  _JihuoniaoFeedAdState createState() => _JihuoniaoFeedAdState();
}

class _JihuoniaoFeedAdState extends State<JihuoniaoFeedAd> {
  double _height = 0;

  Future<void> methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onAdRenderSuccess':
        setState(() {
          _height = call.arguments['height'];
        });
        widget.onAdRenderSuccess?.call();
        break;
      case 'onAdLoadFail':
        final String message = call.arguments['message'];
        widget.onAdLoadFail?.call(message);
        break;
      case 'onAdViewExposure':
        widget.onAdViewExposure?.call();
        break;
      case 'onAdDidClick':
        widget.onAdDidClick?.call();
        break;
      case 'onAdDidClose':
        widget.onAdDidClose?.call();
        break;
      default:
        throw UnsupportedError("Unsupported method");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) return const SizedBox.shrink();

    return SizedBox(
      height: _height,
      child: UiKitView(
        viewType: JihuoniaoFeedAd.viewType,
        creationParams: {'slotId': widget.slotId},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (int id) {
          MethodChannel('${JihuoniaoFeedAd.viewType}/$id')
              .setMethodCallHandler(methodCallHandler);
        },
      ),
    );
  }
}
