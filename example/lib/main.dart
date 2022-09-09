import 'package:flutter/material.dart';

import 'package:flutter_jihuoniao/flutter_jihuoniao.dart';
import 'package:flutter_jihuoniao_example/config/ad_config.dart';
import 'package:flutter_jihuoniao_example/page/feed_ad_page.dart';
import 'package:flutter_jihuoniao_example/page/home_page.dart';

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
      routes: {
        '/HomePage': (context) => const HomePage(),
        '/FeedAdPage': (context) => const FeedAdPage(),
      },
      initialRoute: '/HomePage',
    );
  }
}
