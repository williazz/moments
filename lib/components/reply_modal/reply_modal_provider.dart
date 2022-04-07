import 'package:flutter/material.dart';
import 'package:moments/components/reply_modal/header.dart';
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
  final controller = PanelController();
  final radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  final bar = 35.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SlidingUpPanel(
      controller: controller,
      body: widget.child,
      borderRadius: radius,
      minHeight: 175,
      panel: Padding(
        padding: EdgeInsets.symmetric(vertical: bar),
        child: ReplyPanelWidget(radius: radius),
      ),
      header: Container(
          height: bar,
          width: width,
          decoration: BoxDecoration(borderRadius: radius),
          child: ReplyHeaderWidget(controller: controller)),
      footer: Container(height: bar, width: width, color: Colors.blue),
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
  final scroller = ScrollController();

  @override
  void dispose() {
    scroller.dispose();
    editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scrollbar(
      isAlwaysShown: true,
      controller: scroller,
      child: SingleChildScrollView(
        controller: scroller,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            minLines: 4,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Share something...',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ));
  }
}
