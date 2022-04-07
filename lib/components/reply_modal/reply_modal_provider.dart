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
  final editor = TextEditingController();
  late final ValueNotifier<bool> collapsed;
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
    collapsed = ValueNotifier<bool>(true);
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
    return Stack(children: [
      Column(
        children: [
          Expanded(child: widget.child),
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
                  )
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
                          Text(
                            'Write something...',
                            style: theme.textTheme.subtitle1!
                                .copyWith(color: theme.hintColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      SlidingUpPanel(
        controller: controller,
        borderRadius: radius,
        minHeight: minHeight,
        onPanelClosed: () => collapsed.value = true,
        onPanelOpened: () => collapsed.value = false,
        panel: Padding(
          padding: EdgeInsets.fromLTRB(0, headerHeight, 0, footerHeight),
          child: ReplyPanelWidget(
            radius: radius,
            collapsed: collapsed,
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
              collapsed: collapsed,
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
    ]);
  }
}

class ReplyPanelWidget extends StatefulWidget {
  final BorderRadius radius;
  final ValueNotifier<bool> collapsed;
  final Size? size;
  final FocusNode? focus;
  final TextEditingController editor;
  const ReplyPanelWidget({
    Key? key,
    required this.radius,
    required this.collapsed,
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
            valueListenable: widget.collapsed,
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
