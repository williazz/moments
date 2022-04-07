import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReplyModalProvider extends StatefulWidget {
  final Widget child;
  const ReplyModalProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ReplyModalProvider> createState() => _ReplyModalProviderState();
}

class _ReplyModalProviderState extends State<ReplyModalProvider> {
  final radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      body: widget.child,
      borderRadius: radius,
      panel: ReplyPanelWidget(radius: radius),
    );
  }
}

class ReplyPanelWidget extends StatefulWidget {
  final BorderRadius radius;
  const ReplyPanelWidget({
    Key? key,
    required this.radius,
  }) : super(key: key);
  @override
  State<ReplyPanelWidget> createState() => _ReplyPanelWidgetState();
}

class _ReplyPanelWidgetState extends State<ReplyPanelWidget> {
  final editor = TextEditingController();

  @override
  void dispose() {
    editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        minLines: 3,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Share something...',
          border: InputBorder.none,
        ),
      ),
    ));
  }
}
