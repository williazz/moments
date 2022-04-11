import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/posts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:moments/components/post_skeleton.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:moments/components/post.dart';
import 'package:moments/services/feed.dart';

class FeedWidget extends StatefulWidget {
  final String? username;
  const FeedWidget({
    Key? key,
    this.username,
  }) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Consumer<FeedService>(builder: (_, feed, __) {
        final posts = widget.username == null
            ? feed.home
            : feed.getByUsername(widget.username!);
        return SmartRefresher(
          header: const ClassicHeader(
              idleText: '',
              releaseText: '',
              refreshingText: '',
              completeText: ''),
          key: _refresherKey,
          enablePullDown: true,
          controller: _controller,
          onRefresh: _refresh,
          child: _hasLoadedOnce
              ? _feedWidget(context, posts)
              : _loadingFeedWidget(context),
          footer: CustomFooter(builder: (_, mode) {
            return Text(mode.toString());
          }),
        );
      }),
    );
  }

  _refresh() async {
    setState(() {});
    if (mounted) {
      try {
        await _feed.refresh(username: widget.username);
        await Future.delayed(
            Duration(milliseconds: _hasLoadedOnce ? 500 : 1300));
        setState(() => _hasLoadedOnce = true);
        _controller.refreshCompleted();
      } catch (_) {
        showAlertDialog(
          context: context,
          title: 'Unable to load feed',
          content: 'Please try again in a few moments',
        );
        _controller.refreshFailed();
      }
    }
  }

  final _contentKey = GlobalKey();
  Widget _feedWidget(BuildContext context, List<Post> posts) {
    return ListView.separated(
      key: _contentKey,
      itemCount: posts.length,
      itemBuilder: (_, index) {
        final post = posts[index];
        return PostWidget(post: post);
      },
      separatorBuilder: (_, __) => const Divider(),
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
