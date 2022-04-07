import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/util/show_snackbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReplyHeaderWidget extends StatefulWidget {
  final PanelController controller;
  final ValueNotifier<bool> collapsed;
  final TextEditingController editor;
  final FocusNode? focus;
  final ValueNotifier<bool> hideKeyboard;
  const ReplyHeaderWidget({
    Key? key,
    required this.controller,
    required this.collapsed,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: widget.hideKeyboard,
            builder: (context, shouldHide, _) {
              return IconButton(
                  onPressed: () => hide(context),
                  icon: Icon(shouldHide
                      ? CupertinoIcons.keyboard_chevron_compact_down
                      : CupertinoIcons.clear));
            }),
        const Icon(Icons.drag_handle_rounded),
        ValueListenableBuilder<bool>(
            valueListenable: widget.collapsed,
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

  hide(BuildContext context) {
    final focus = FocusScope.of(context);
    if (focus.hasFocus) {
      focus.unfocus();
      if (widget.editor.text.isEmpty) {
        widget.controller.hide();
        widget.editor.clear();
      } else {
        widget.controller.close();
      }
    } else {
      widget.controller.hide();
      if (widget.editor.text.isNotEmpty) {
        showSnackBar(context, 'Draft discarded');
        widget.editor.clear();
      }
    }
  }
}
