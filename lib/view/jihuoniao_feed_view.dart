import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JihuoniaoFeedAd extends StatefulWidget {
  static const String viewType = 'flutter_jihuoniao_feed_ad';

  final String slotId;

  const JihuoniaoFeedAd({Key? key, required this.slotId}) : super(key: key);

  @override
  _JihuoniaoFeedAdState createState() => _JihuoniaoFeedAdState();
}

class _JihuoniaoFeedAdState extends State<JihuoniaoFeedAd> {
  final double _height = 0;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) return const SizedBox.shrink();

    return SizedBox(
      height: _height,
      child: UiKitView(
        viewType: JihuoniaoFeedAd.viewType,
        creationParams: {'slotId': widget.slotId},
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
