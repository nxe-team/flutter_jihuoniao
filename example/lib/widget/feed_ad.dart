import 'package:flutter/material.dart';
import 'package:flutter_jihuoniao/view/jihuoniao_feed_view.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';

class FeedAd extends StatefulWidget {
  const FeedAd({Key? key}) : super(key: key);

  @override
  State<FeedAd> createState() => _FeedAdState();
}

class _FeedAdState extends State<FeedAd> with AutomaticKeepAliveClientMixin {
  /// 广告高度
  double _height = 0.01;

  /// 是否已移除
  bool _isRemoved = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isRemoved) return const SizedBox.shrink();

    return AnimatedSize(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.white,
        height: _height,
        child: JihuoniaoFeedAd(
          slotId: AdConfig.feedId,
          onAdRenderSuccess: (double height) {
            setState(() {
              _height = height;
            });
          },
          onAdLoadFail: (String message) {
            print('FeedAd | 加载失败 $message');
          },
          onAdDidClose: () {
            setState(() {
              _isRemoved = true;
            });
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
