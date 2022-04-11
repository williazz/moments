import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moments/components/reply_feed_widget.dart';

import 'package:moments/repos/posts.dart';
import 'package:timeago/timeago.dart' as timeago;

enum VoteState {
  none,
  up,
  down,
}

class PostWidget extends StatefulWidget {
  final Post post;
  final VoteState initialVoteState;
  const PostWidget({
    Key? key,
    required this.post,
    this.initialVoteState = VoteState.none,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final iconSize = 20.0;
  late VoteState voteState;
  final raw = Random().nextInt(pow(10, 6).toInt());
  int get score {
    // naive
    switch (voteState) {
      case VoteState.up:
        return raw + 1;
      case VoteState.down:
        return raw - 1;
      default:
        return raw;
    }
  }

  String get uiScore => NumberFormat.compact(locale: 'en_US').format(score);

  @override
  void initState() {
    super.initState();
    voteState = widget.initialVoteState;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final ago = timeago.format(widget.post.timestamp, locale: 'en_short');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: widget.post.username,
                style:
                    theme.textTheme.bodyLarge!.copyWith(color: colors.primary),
                children: [
              TextSpan(
                  text: ' • $ago',
                  style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.normal, color: theme.hintColor))
            ])),
        Text(widget.post.body,
            style:
                theme.textTheme.bodyMedium!.copyWith(color: colors.onSurface)),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: iconSize,
                  color: theme.hintColor,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.ellipsis)),
              IconButton(
                  iconSize: iconSize,
                  color: theme.hintColor,
                  onPressed: () {
                    RepliableFeedController.of(context)?.replyingTo.value =
                        widget.post;
                  },
                  icon: const Icon(CupertinoIcons.reply)),
              IconButton(
                  iconSize: iconSize,
                  color: voteState == VoteState.down
                      ? theme.colorScheme.primary
                      : theme.hintColor,
                  onPressed: () => _vote(VoteState.down),
                  icon: const Icon(CupertinoIcons.arrow_down)),
              Text(uiScore,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.hintColor)),
              IconButton(
                  iconSize: iconSize,
                  color: voteState == VoteState.up
                      ? theme.colorScheme.secondary
                      : theme.hintColor,
                  onPressed: () => _vote(VoteState.up),
                  icon: const Icon(CupertinoIcons.arrow_up)),
            ]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final child in widget.post.children)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(width: 1, color: theme.dividerColor),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: PostWidget(post: child),
                    ),
                  ),
                )
            ]),
      ],
    );
  }

  _vote(VoteState state) {
    if (state == voteState) return;
    setState(() {
      voteState = state;
    });
  }
}
