import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String get score {
    int res = raw;
    switch (voteState) {
      case VoteState.none:
        break;
      case VoteState.up:
        res++;
        break;
      case VoteState.down:
        res--;
        break;
    }
    return NumberFormat.compact(locale: 'en_US').format(res);
  }

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: widget.post.username,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: colors.primary),
                  children: [
                TextSpan(
                    text: ' • $ago',
                    style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal, color: theme.hintColor))
              ])),
          Text(widget.post.body,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: colors.onSurface)),
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
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.reply)),
              IconButton(
                  iconSize: iconSize,
                  color: voteState == VoteState.down
                      ? theme.colorScheme.primary
                      : theme.hintColor,
                  onPressed: () => _vote(VoteState.down),
                  icon: const Icon(CupertinoIcons.arrow_down)),
              Text(score,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.hintColor)),
              IconButton(
                  iconSize: iconSize,
                  color: voteState == VoteState.up
                      ? theme.colorScheme.secondary
                      : theme.hintColor,
                  onPressed: () => _vote(VoteState.up),
                  icon: const Icon(CupertinoIcons.arrow_up)),
            ],
          ),
        ],
      ),
    );
  }

  _vote(VoteState state) {
    if (state == voteState) return;
    setState(() {
      voteState = state;
    });
  }
}
