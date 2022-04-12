import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:moments/components/feed.dart';
import 'package:moments/components/reply_modal/footer.dart';
import 'package:moments/components/reply_modal/header.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/services/feed.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:moments/util/show_snackbar.dart';

class RepliableFeedStateProvider extends InheritedWidget {
  final PanelController controller;
  final replyingTo = ValueNotifier<Post?>(null);
  final TextEditingController editor;
  final ValueNotifier<bool> collapser;
  final ValueNotifier<bool> hideKeyboard;
  final FocusNode focus;
  final BorderRadius radius;
  final feed = GetIt.I<FeedService>();
  post(BuildContext context) async {
    try {
      final body = editor.value.text;
      if (replyingTo.value != null) {
        final parent = replyingTo.value!;
        await feed.reply(body, parent);
      } else {
        await feed.add(body);
      }
      controller.hide();
      editor.clear();
      showSnackBar(context, 'Posted successfully!');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unable to post',
          content: 'Please try again');
    }
  }

  RepliableFeedStateProvider({
    Key? key,
    required this.controller,
    required this.editor,
    required this.collapser,
    required this.hideKeyboard,
    required this.focus,
    required this.radius,
    required Widget child,
  }) : super(key: key, child: child);

  static RepliableFeedStateProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RepliableFeedStateProvider>();
  }

  @override
  bool updateShouldNotify(RepliableFeedStateProvider oldWidget) => true;
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
      editor: editor,
      collapser: collapser,
      focus: focus,
      hideKeyboard: hideKeyboard,
      radius: radius,
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
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  controller.show();
                },
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
          defaultPanelState: PanelState.HIDDEN,
          onPanelClosed: () => collapser.value = true,
          onPanelOpened: () => collapser.value = false,
          panel: Padding(
            padding: EdgeInsets.fromLTRB(0, headerHeight, 0, footerHeight),
            child: ReplyPanelWidget(
              size: size,
            ),
          ),
          header: Container(
              height: headerHeight,
              width: size.width,
              decoration: BoxDecoration(borderRadius: radius),
              child: const ReplyHeaderWidget()),
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
  final Size? size;
  const ReplyPanelWidget({Key? key, this.size}) : super(key: key);
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
    final state = RepliableFeedStateProvider.of(context)!;
    return SafeArea(
        child: ValueListenableBuilder<bool>(
            valueListenable: state.collapser,
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
                            focusNode: state.focus,
                            controller: state.editor,
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

  post() async {}
}
