import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({
    Key? key,
    @PathParam() required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepliableFeedWidget(
      username: username,
      child: Container(
        color: Colors.blue,
        height: 100,
        child: Center(
          child: Text(
            username,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
