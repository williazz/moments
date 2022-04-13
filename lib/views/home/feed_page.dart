import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.background,
        body: const RepliableFeedWidget(),
      ),
    );
  }
}
