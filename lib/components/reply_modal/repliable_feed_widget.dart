import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:moments/components/feed.dart';
import 'package:moments/components/reply_modal/footer.dart';
import 'package:moments/components/reply_modal/header.dart';
import 'package:moments/repos/posts.dart';

class RepliableFeedStateProvider extends InheritedWidget {
  final PanelController controller;
  final replyingTo = ValueNotifier<Post?>(null);
  RepliableFeedStateProvider({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  static RepliableFeedStateProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepliableFeedStateProvider>();
  }

  @override
  bool updateShouldNotify(RepliableFeedStateProvider oldWidget) =>
      controller.panelPosition != oldWidget.controller.panelPosition;
}

class RepliableFeedWidget extends StatefulWidget {
  final String? username;
  const RepliableFeedWidget({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<RepliableFeedWidget> createState() => _RepliableFeedWidgetState();
}

class _RepliableFeedWidgetState extends State<RepliableFeedWidget> {
  final controller = PanelController();
  final editor = TextEditingController();
  final collapser = ValueNotifier<bool>(true);
  final hideKeyboard = ValueNotifier<bool>(true);
  final focus = FocusNode();

  final radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  final headerHeight = 35.0;
  final footerHeight = 40.0;
  final minHeight = 175.0;

  @override
  void initState() {
    super.initState();
    focus.addListener(() => hideKeyboard.value = focus.hasFocus);
  }

  @override
  void dispose() {
    editor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return RepliableFeedStateProvider(
      controller: controller,
      child: Stack(children: [
        Column(children: [
          Expanded(child: FeedWidget(username: widget.username)),
          Container(
            height: 60,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: radius,
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 5,
                  ),
                ]),
            child: Material(
              borderRadius: radius,
              child: GestureDetector(
                onTap: controller.show,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      // color: theme.,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Write something...',
                              style: theme.textTheme.subtitle1!
                                  .copyWith(color: theme.hintColor)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
        SlidingUpPanel(
          controller: controller,
          borderRadius: radius,
          minHeight: minHeight,
          onPanelClosed: () => collapser.value = true,
          onPanelOpened: () => collapser.value = false,
          panel: Padding(
            padding: EdgeInsets.fromLTRB(0, headerHeight, 0, footerHeight),
            child: ReplyPanelWidget(
              radius: radius,
              collapser: collapser,
              size: size,
              focus: focus,
              editor: editor,
            ),
          ),
          header: Container(
              height: headerHeight,
              width: size.width,
              decoration: BoxDecoration(borderRadius: radius),
              child: ReplyHeaderWidget(
                focus: focus,
                controller: controller,
                hideKeyboard: hideKeyboard,
                collapser: collapser,
                editor: editor,
              )),
          footer: Material(
            color: theme.dialogBackgroundColor,
            child: Container(
              height: footerHeight,
              width: size.width,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 0.1))),
              child: const ReplyFooterWidget(),
            ),
          ),
        ),
      ]),
    );
  }
}

class ReplyPanelWidget extends StatefulWidget {
  final BorderRadius radius;
  final ValueNotifier<bool> collapser;
  final Size? size;
  final FocusNode? focus;
  final TextEditingController editor;
  const ReplyPanelWidget({
    Key? key,
    required this.radius,
    required this.collapser,
    required this.editor,
    this.focus,
    this.size,
  }) : super(key: key);
  @override
  State<ReplyPanelWidget> createState() => _ReplyPanelWidgetState();
}

class _ReplyPanelWidgetState extends State<ReplyPanelWidget> {
  final scroller = ScrollController();

  double? get maxHeight {
    if (widget.size == null) return null;
    return widget.size!.height - 515;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ValueListenableBuilder<bool>(
            valueListenable: widget.collapser,
            builder: (context, collapsed, _) {
              return Column(
                children: [
                  SizedBox(
                    height: collapsed ? 100 : maxHeight,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      controller: scroller,
                      child: SingleChildScrollView(
                        controller: scroller,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            autofocus: true,
                            focusNode: widget.focus,
                            controller: widget.editor,
                            minLines: 4,
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Write something...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
