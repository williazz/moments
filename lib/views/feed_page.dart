import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:moments/components/appbar.dart';
import 'package:moments/components/post.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/feed.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = GetIt.I<FeedService>();

    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(onPressed: feed.getAll, child: const Text('Refresh')),
          Expanded(
            child: Consumer<FeedService>(
                builder: (_, feed, __) => ListView.builder(
                    itemCount: feed.posts.length,
                    itemBuilder: (_, index) {
                      final post = feed.posts[index];
                      return PostWidget(post: post);
                    })),
          ),
        ],
      ),
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
