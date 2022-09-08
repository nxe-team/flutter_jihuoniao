import 'package:flutter/material.dart';
import 'package:flutter_jihuoniao/view/jihuoniao_feed_view.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';

class FeedAd extends StatelessWidget {
  const FeedAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JihuoniaoFeedAd(
      slotId: AdConfig.feedId,
    );
  }
}
