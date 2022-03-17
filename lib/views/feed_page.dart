import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/components/post_skeleton.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final _feed = GetIt.I<FeedService>();
  bool _hasLoadedOnce = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<FeedService>(builder: (_, feed, __) {
        return SmartRefresher(
          header: const ClassicHeader(
              idleText: '',
              releaseText: '',
              refreshingText: '',
              completeText: ''),
          key: _refresherKey,
          enablePullDown: true,
          controller: _controller,
          onRefresh: _getLatestFeed,
          child: _hasLoadedOnce
              ? _feedWidget(context, feed)
              : _loadingFeedWidget(context),
          footer: CustomFooter(builder: (_, mode) {
            return Text(mode.toString());
          }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreatePost(context),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  _getLatestFeed() async {
    setState(() {});
    if (mounted) {
      try {
        await _feed.getAll();
        if (!_hasLoadedOnce) {
          await Future.delayed(const Duration(milliseconds: 1300));
        }
        setState(() => _hasLoadedOnce = true);
        _controller.refreshCompleted();
      } catch (_) {
        showAlertDialog(
            context: context,
            title: 'Unable to load feed',
            content: 'Please try again in a few moments');
        _controller.refreshFailed();
      }
    }
  }

  _navigateToCreatePost(BuildContext context) {
    AutoRouter.of(context).push(const CreatePostRoute());
  }

  final _contentKey = GlobalKey();
  Widget _feedWidget(BuildContext context, FeedService feed) {
    return ListView.separated(
      key: _contentKey,
      itemCount: feed.posts.length,
      itemBuilder: (_, index) {
        final post = feed.posts[index];
        return PostWidget(post: post);
      },
      separatorBuilder: (_, index) {
        return const Divider();
      },
    );
  }

  final _loadingKey = GlobalKey();
  Widget _loadingFeedWidget(BuildContext context) {
    return ListView.builder(
      key: _loadingKey,
      itemCount: 5,
      itemBuilder: (_, __) {
        return const SkeletonPostWidget();
      },
    );
  }
}
