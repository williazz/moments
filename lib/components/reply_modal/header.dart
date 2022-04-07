import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReplyHeaderWidget extends StatefulWidget {
  final PanelController controller;
  const ReplyHeaderWidget({
    Key? key,
    required this.controller,
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
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.clear)),
        IconButton(
            onPressed: toggle,
            icon: Icon(collapsed
                ? CupertinoIcons.fullscreen
                : CupertinoIcons.fullscreen_exit)),
      ],
    );
  }

  toggle() async {
    if (collapsed) {
      await widget.controller.open();
    } else {
      await widget.controller.close();
    }
    setState(() {});
  }
}
