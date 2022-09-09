import 'package:flutter/material.dart';
import 'package:flutter_jihuoniao/view/jihuoniao_feed_view.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';

class FeedAd extends StatefulWidget {
  const FeedAd({Key? key}) : super(key: key);

  @override
  State<FeedAd> createState() => _FeedAdState();
}

class _FeedAdState extends State<FeedAd> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return JihuoniaoFeedAd(
      slotId: AdConfig.feedId,
      onAdLoadFail: (String message) {
        print('FeedAd | 加载失败 $message');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
