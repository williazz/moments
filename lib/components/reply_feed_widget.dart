import 'package:flutter/material.dart';
import 'package:moments/components/feed.dart';
import 'package:moments/components/reply_modal/reply_modal_provider.dart';
import 'package:moments/repos/posts.dart';

class RepliableFeedController extends InheritedWidget {
  final replyingTo = ValueNotifier<Post?>(null);
  RepliableFeedController({Key? key, required Widget child})
      : super(key: key, child: child);

  static RepliableFeedController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepliableFeedController>();
  }

  @override
  bool updateShouldNotify(RepliableFeedController oldWidget) {
    return true;
  }
}

class RepliableFeedWidget extends StatefulWidget {
  final String? username;
  const RepliableFeedWidget({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<RepliableFeedWidget> createState() => _RepliableFeedWidgetState();
}

class _RepliableFeedWidgetState extends State<RepliableFeedWidget> {
  @override
  Widget build(BuildContext context) {
    return RepliableFeedController(
      child: ReplyModalWrapper(
        child: FeedWidget(username: widget.username),
      ),
    );
  }
}
