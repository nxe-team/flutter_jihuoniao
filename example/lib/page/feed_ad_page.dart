import 'package:flutter/material.dart';
import 'package:flutter_jihuoniao_example/widget/feed_ad.dart';

class FeedAdPage extends StatefulWidget {
  const FeedAdPage({Key? key}) : super(key: key);

  @override
  _FeedAdPageState createState() => _FeedAdPageState();
}

class _FeedAdPageState extends State<FeedAdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Ad'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index % 5 == 0) {
            return const FeedAd();
          }

          return Container(
            height: 160,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.black12)),
            ),
            child: Center(
              child: Text(index.toString()),
            ),
          );
        },
      ),
    );
  }
}
