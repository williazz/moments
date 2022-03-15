import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/components/post.dart';
import 'package:moments/services/feed.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feed = GetIt.I<FeedService>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: feed.add, child: const Text('Add Post')),
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
    );
  }
}
