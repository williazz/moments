import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moments/repos/posts.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final ago = timeago.format(post.timestamp, locale: 'en_short');
    final raw = Random().nextInt(pow(10, 6).toInt());
    final score = NumberFormat.compact(locale: 'en_US').format(raw);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: post.username,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: colors.primary),
                  children: [
                TextSpan(
                    text: ' • $ago',
                    style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal, color: theme.hintColor))
              ])),
          Text(post.body,
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
                  color: theme.hintColor,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_down)),
              Text(score,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.hintColor)),
              IconButton(
                  iconSize: iconSize,
                  color: theme.hintColor,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_up)),
            ],
          ),
        ],
      ),
    );
  }
}
