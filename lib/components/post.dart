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
    final ago = timeago.format(post.timestamp);
    return ListTile(
      title: RichText(
        text: TextSpan(
            text: post.title,
            style: theme.textTheme.subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: ' • $ago',
                  style: theme.textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.normal, color: theme.hintColor))
            ]),
      ),
      subtitle: post.body == null
          ? null
          : Text(post.body!,
              style: TextStyle(color: theme.colorScheme.onSurface)),
    );
  }
}
