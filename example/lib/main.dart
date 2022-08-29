import 'package:flutter/material.dart';

import 'package:flutter_jihuoniao/flutter_jihuoniao.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterJihuoniao.initSDK(
      appId: AdConfig.appId,
      appKey: AdConfig.appKey,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter JiHuoNiao Example'),
        ),
        body: Center(
          child: Column(
            children: [
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
                      slotId: AdConfig.interstitialId);
                },
                child: const Text('插屏广告'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
