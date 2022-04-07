import 'package:flutter/material.dart';
import 'package:moments/components/feed.dart';
import 'package:moments/components/reply_modal/reply_modal_provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.background,
        body: const ReplyModalProvider(child: FeedWidget()),
      ),
    );
  }
}
