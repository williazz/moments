import 'package:flutter/material.dart';
import 'package:moments/components/reply_modal/footer.dart';
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
  late final ValueNotifier<bool> collapsed;

  final radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  final headerHeight = 35.0;
  final footerHeight = 40.0;

  @override
  void initState() {
    super.initState();
    collapsed = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return SlidingUpPanel(
      controller: controller,
      body: widget.child,
      borderRadius: radius,
      minHeight: 175,
      onPanelClosed: () => collapsed.value = true,
      onPanelOpened: () => collapsed.value = false,
      panel: Padding(
        padding:
            EdgeInsets.fromLTRB(0, headerHeight, 0, 2 * footerHeight + 3.5),
        child: ReplyPanelWidget(radius: radius),
      ),
      header: Container(
          height: headerHeight,
          width: width,
          decoration: BoxDecoration(borderRadius: radius),
          child: ReplyHeaderWidget(
            controller: controller,
            collapsed: collapsed,
          )),
      footer: Material(
        color: theme.dialogBackgroundColor,
        child: Container(
          height: footerHeight,
          width: width,
          decoration:
              const BoxDecoration(border: Border(top: BorderSide(width: 0.1))),
          child: const ReplyFooterWidget(),
        ),
      ),
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
