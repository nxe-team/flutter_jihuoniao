import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

class JihuoniaoFeedAd extends StatefulWidget {
  static const String viewType = 'flutter_jihuoniao_feed_ad';

  /// 广告位 ID
  final String slotId;

  /// 广告渲染成功
  final void Function(double height)? onAdRenderSuccess;

  /// 广告渲染成功
  /// 快手广告加载后会自渲染，需在该回调使用其高度
  /// 其他广告该回调高度为 0，需在 onAdRenderSuccess 回调中取高度
  final void Function(double height)? onAdDidLoad;

  /// 广告加载失败
  final void Function(String message)? onAdLoadFail;

  /// 广告被曝光
  final void Function()? onAdViewExposure;

  /// 广告被点击
  final void Function()? onAdDidClick;

  /// 广告已广告
  final void Function()? onAdDidClose;

  const JihuoniaoFeedAd({
    Key? key,
    required this.slotId,
    this.onAdRenderSuccess,
    this.onAdDidLoad,
    this.onAdLoadFail,
    this.onAdViewExposure,
    this.onAdDidClick,
    this.onAdDidClose,
  }) : super(key: key);

  @override
  _JihuoniaoFeedAdState createState() => _JihuoniaoFeedAdState();
}

class _JihuoniaoFeedAdState extends State<JihuoniaoFeedAd> {
  final UniqueKey _detectorKey = UniqueKey();
  MethodChannel? _methodChannel;

  Future<void> methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onAdRenderSuccess':
        final double height = call.arguments['height'];
        widget.onAdRenderSuccess?.call(height);
        break;
      case 'onAdDidLoad':
        final double height = call.arguments['height'];
        widget.onAdDidLoad?.call(height);
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

    return VisibilityDetector(
      key: _detectorKey,
      child: UiKitView(
        viewType: JihuoniaoFeedAd.viewType,
        creationParams: {'slotId': widget.slotId},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (int id) {
          _methodChannel = MethodChannel('${JihuoniaoFeedAd.viewType}/$id');
          _methodChannel!.setMethodCallHandler(methodCallHandler);
        },
      ),
      onVisibilityChanged: (VisibilityInfo visibilityInfo) {
        if (!mounted) return;
        // 被遮盖了
        final bool isCovered = visibilityInfo.visibleFraction != 1.0;
        final Offset offset = (context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
        _methodChannel?.invokeMethod('updateVisibleBounds', {
          'isCovered': isCovered,
          'x': offset.dx + visibilityInfo.visibleBounds.left,
          'y': offset.dy + visibilityInfo.visibleBounds.top,
          'width': visibilityInfo.visibleBounds.width,
          'height': visibilityInfo.visibleBounds.height,
        });
      },
    );
  }
}
