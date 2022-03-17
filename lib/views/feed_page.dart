import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:moments/components/appbar.dart';
import 'package:moments/components/post.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/feed.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _controller = RefreshController(initialRefresh: true);
  final _refresherKey = GlobalKey();
  final _contentKey = GlobalKey();
  final _feed = GetIt.I<FeedService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Consumer<FeedService>(builder: (_, feed, __) {
        return SmartRefresher(
            key: _refresherKey,
            enablePullDown: true,
            controller: _controller,
            onRefresh: _onRefresh,
            onLoading: _onLoad,
            child: ListView.builder(
                key: _contentKey,
                itemCount: feed.posts.length,
                itemBuilder: (_, index) {
                  final post = feed.posts[index];
                  return PostWidget(post: post);
                }));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreatePost(context),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  _onLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _feed.getAll();
    }
    _controller.loadComplete();
  }

  _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _feed.getAll();
    }
    _controller.refreshCompleted();
  }

  _navigateToCreatePost(BuildContext context) {
    AutoRouter.of(context).push(const CreatePostRoute());
  }
}
