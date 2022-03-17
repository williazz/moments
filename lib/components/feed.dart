import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:moments/components/post_skeleton.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:moments/components/post.dart';
import 'package:moments/services/feed.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _controller = RefreshController(initialRefresh: true);
  final _refresherKey = GlobalKey();
  final _feed = GetIt.I<FeedService>();
  bool _hasLoadedOnce = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedService>(builder: (_, feed, __) {
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
    });
  }

  _getLatestFeed() async {
    setState(() {});
    if (mounted) {
      try {
        await _feed.getAll();
        await Future.delayed(
            Duration(milliseconds: _hasLoadedOnce ? 500 : 1300));
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
