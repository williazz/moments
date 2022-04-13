import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/util/show_snackbar.dart';

class ReplyHeaderWidget extends StatefulWidget {
  const ReplyHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ReplyHeaderWidget> createState() => _ReplyHeaderWidgetState();
}

class _ReplyHeaderWidgetState extends State<ReplyHeaderWidget> {
  late final RepliableFeedStateProvider state;
  bool get collapsed => state.controller.isPanelClosed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = RepliableFeedStateProvider.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    final replyingTo = RepliableFeedStateProvider.of(context)?.replyingTo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: state.hideKeyboard,
            builder: (context, shouldHide, _) {
              return IconButton(
                  onPressed: () {
                    hide(context);
                  },
                  icon: Icon(shouldHide
                      ? CupertinoIcons.keyboard_chevron_compact_down
                      : CupertinoIcons.clear));
            }),
        if (replyingTo == null) const Icon(Icons.drag_handle_rounded),
        if (replyingTo != null)
          ValueListenableBuilder<Post?>(
              valueListenable: replyingTo,
              builder: (_, post, __) {
                if (post == null) {
                  return const Icon(Icons.drag_handle_rounded);
                }
                return Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: 'Replying to ',
                            style: DefaultTextStyle.of(context).style,
                            children: [
                      TextSpan(
                        text: post.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ])));
              }),
        ValueListenableBuilder<bool>(
            valueListenable: state.collapser,
            builder: (context, collapsed, _) {
              return IconButton(
                  onPressed: toggleFullscreen,
                  icon: Icon(collapsed
                      ? CupertinoIcons.fullscreen
                      : CupertinoIcons.fullscreen_exit));
            }),
      ],
    );
  }

  toggleFullscreen() async {
    if (collapsed) {
      state.focus.requestFocus();
      await state.controller.open();
    } else {
      await state.controller.close();
    }
    if (mounted) setState(() {});
  }

  clearReplyingTo(BuildContext context) {
    RepliableFeedStateProvider.of(context)?.replyingTo.value = null;
  }

  hide(BuildContext context) {
    final focus = FocusScope.of(context);
    if (focus.hasFocus) {
      focus.unfocus();
      if (state.editor.text.isEmpty) {
        state.controller.hide();
        clearReplyingTo(context);
        state.editor.clear();
      } else {
        state.controller.close();
      }
    } else {
      state.controller.hide();
      clearReplyingTo(context);
      if (state.editor.text.isNotEmpty) {
        showSnackBar(context, 'Draft discarded');
        state.editor.clear();
      }
    }
  }
}
