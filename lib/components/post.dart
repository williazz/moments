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
    final ago = timeago.format(post.timestamp);
    return ListTile(title: Text(post.title), subtitle: Text(ago));
  }
}
