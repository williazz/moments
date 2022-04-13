import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({
    Key? key,
    @PathParam() required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: username),
      backgroundColor: theme.dialogBackgroundColor,
      body: RepliableFeedWidget(
        username: username,
      ),
    );
  }
}
