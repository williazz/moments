import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:moments/components/feed.dart';
import 'package:moments/router/router.gr.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const FeedWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreatePost(context),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  _navigateToCreatePost(BuildContext context) {
    AutoRouter.of(context).push(const CreatePostRoute());
  }
}
