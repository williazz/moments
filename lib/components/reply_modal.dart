import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/components/rounded_elevated_button.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/services/feed.dart';
import 'package:moments/services/register.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:moments/util/show_snackbar.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ReplyModal extends StatefulWidget {
  final SheetController sheetController;
  final TextEditingController bodyController;
  const ReplyModal({
    Key? key,
    required this.sheetController,
    required this.bodyController,
  }) : super(key: key);

  @override
  State<ReplyModal> createState() => _ReplyModalState();
}

class _ReplyModalState extends State<ReplyModal> {
  final iconSize = 25.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            autofocus: true,
            onChanged: (_) => _update(),
            controller: widget.bodyController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            minLines: 50,
            maxLines: null,
            autocorrect: true,
            decoration: const InputDecoration(
                hintText: 'Write a reply', border: InputBorder.none),
          ),
        )
      ],
    );
  }

  _update() {
    setState(() {});
  }
}

class _FooterWidget extends StatefulWidget {
  final SheetController sheetController;
  final TextEditingController bodyController;
  const _FooterWidget({
    Key? key,
    required this.sheetController,
    required this.bodyController,
  }) : super(key: key);

  @override
  State<_FooterWidget> createState() => __FooterWidgetState();
}

class __FooterWidgetState extends State<_FooterWidget> {
  final _feed = GetIt.I<FeedService>();
  final _register = GetIt.I<RegisterService>();
  bool _submitting = false;
  bool get locked => widget.bodyController.text.isEmpty || _submitting;
  bool get shouldExpand {
    final state = widget.sheetController.state;
    if (state == null) return false;
    return state.isCollapsed;
  }

  @override
  void initState() {
    super.initState();
    widget.bodyController.addListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          RoundedElevatedButton(
              title: 'Post', onPressed: locked ? null : _submit),
        ]));
  }

  _submit() async {
    try {
      setState(() => _submitting = true);
      final post = Post(
          username: _register.profile!.username,
          body: widget.bodyController.text);
      await _feed.add(post);
      Navigator.of(context).pop();
      showSnackBar(context, 'Reply posted!');
    } catch (_) {
      setState(() => _submitting = false);
      showAlertDialog(
          context: context,
          title: 'Failed to post reply',
          content: 'Please try again');
    }
  }

  _update() => setState(() {});
}

class _HeaderWidget extends StatefulWidget {
  final SheetController sheetController;
  final TextEditingController bodyController;
  const _HeaderWidget({
    Key? key,
    required this.sheetController,
    required this.bodyController,
  }) : super(key: key);

  @override
  State<_HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<_HeaderWidget> {
  bool get shouldExpand {
    final state = widget.sheetController.state;
    if (state == null) return true;
    return !state.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 25.0;
    return Material(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          iconSize: iconSize,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.clear)),
      const Icon(Icons.drag_handle_rounded, size: iconSize),
      IconButton(
          iconSize: iconSize,
          onPressed: () async {
            if (shouldExpand) {
              await widget.sheetController.expand();
            } else {
              await widget.sheetController.collapse();
            }
            _update();
          },
          icon: Icon(shouldExpand
              ? CupertinoIcons.fullscreen
              : CupertinoIcons.fullscreen_exit)),
    ]));
  }

  _update() {
    setState(() {});
  }
}

showReplyModal(BuildContext context) {
  final theme = Theme.of(context);
  final sheetController = SheetController();
  final bodyController = TextEditingController();

  showSlidingBottomSheet(context, builder: (BuildContext context) {
    return SlidingSheetDialog(
        dismissOnBackdropTap: false,
        headerBuilder: (_, __) => _HeaderWidget(
            sheetController: sheetController, bodyController: bodyController),
        footerBuilder: (_, __) => _FooterWidget(
            sheetController: sheetController, bodyController: bodyController),
        controller: sheetController,
        backdropColor: Colors.transparent,
        elevation: 16.0,
        cornerRadius: 16.0,
        duration: const Duration(milliseconds: 250),
        color: theme.scaffoldBackgroundColor,
        snapSpec: const SnapSpec(snappings: [0.4, 1.0]),
        builder: (context, __) => ReplyModal(
              sheetController: sheetController,
              bodyController: bodyController,
            ));
  });
}
