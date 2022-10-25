import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jihuoniao/flutter_jihuoniao.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter JiHuoNiao Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (Platform.isIOS) return;
                FlutterJihuoniao.requestNecessaryPermissions();
              },
              child: const Text('请求必要的权限 Android'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterJihuoniao.showSplashAd(slotId: AdConfig.splashId);
              },
              child: const Text('开屏广告'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterJihuoniao.showSplashAd(
                  slotId: AdConfig.splashId,
                  logo: 'SplashBottomLogo',
                );
              },
              child: const Text('开屏广告（带Logo）'),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterJihuoniao.showInterstitialAd(
                  context: context,
                  slotId: AdConfig.interstitialId,
                );
              },
              child: const Text('插屏广告'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FeedAdPage');
              },
              child: const Text('信息流广告'),
            )
          ],
        ),
      ),
    );
  }
}
