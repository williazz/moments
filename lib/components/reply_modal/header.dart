import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/reply_feed_widget.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/util/show_snackbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReplyHeaderWidget extends StatefulWidget {
  final PanelController controller;
  final ValueNotifier<bool> collapser;
  final TextEditingController editor;
  final FocusNode? focus;
  final ValueNotifier<bool> hideKeyboard;
  const ReplyHeaderWidget({
    Key? key,
    required this.controller,
    required this.collapser,
    required this.editor,
    required this.hideKeyboard,
    this.focus,
  }) : super(key: key);

  @override
  State<ReplyHeaderWidget> createState() => _ReplyHeaderWidgetState();
}

class _ReplyHeaderWidgetState extends State<ReplyHeaderWidget> {
  bool get collapsed => widget.controller.isPanelClosed;

  @override
  Widget build(BuildContext context) {
    final replyingTo = RepliableFeedController.of(context)?.replyingTo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: widget.hideKeyboard,
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
            valueListenable: widget.collapser,
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
      widget.focus?.requestFocus();
      await widget.controller.open();
    } else {
      await widget.controller.close();
    }
    setState(() {});
  }

  clearReplyingTo(BuildContext context) {
    RepliableFeedController.of(context)?.replyingTo.value = null;
  }

  hide(BuildContext context) {
    final focus = FocusScope.of(context);
    if (focus.hasFocus) {
      focus.unfocus();
      if (widget.editor.text.isEmpty) {
        widget.controller.hide();
        clearReplyingTo(context);
        widget.editor.clear();
      } else {
        widget.controller.close();
      }
    } else {
      widget.controller.hide();
      clearReplyingTo(context);
      if (widget.editor.text.isNotEmpty) {
        showSnackBar(context, 'Draft discarded');
        widget.editor.clear();
      }
    }
  }
}
