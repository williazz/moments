import 'package:flutter/material.dart';
import 'package:moments/components/feed.dart';

class YouPage extends StatelessWidget {
  const YouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedWidget(username: 'billy'),
    );
  }
}
