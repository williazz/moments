import 'package:flutter/material.dart';
import 'package:moments/repos/posts.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final ago = timeago.format(post.timestamp, locale: 'en_short');
    return ListTile(
      tileColor: theme.colorScheme.background,
      title: RichText(
          text: TextSpan(
              text: '@${post.username ?? 'guest'}',
              style: theme.textTheme.subtitle1!
                  .copyWith(fontWeight: FontWeight.bold, color: colors.primary),
              children: [
            TextSpan(
                text: ' • $ago',
                style: theme.textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.normal, color: theme.hintColor))
          ])),
      subtitle: Text(post.title,
          style: theme.textTheme.subtitle1!.copyWith(color: colors.onSurface)),
    );
  }
}
