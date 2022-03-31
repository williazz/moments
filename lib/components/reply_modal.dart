import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/rounded_elevated_button.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ReplyModal extends StatefulWidget {
  final SheetController sheetController;
  const ReplyModal({
    Key? key,
    required this.sheetController,
  }) : super(key: key);

  @override
  State<ReplyModal> createState() => _ReplyModalState();
}

class _ReplyModalState extends State<ReplyModal> {
  final iconSize = 25.0;
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            autofocus: true,
            onChanged: _update,
            controller: _bodyController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
            minLines: 50,
            maxLines: null,
            autocorrect: true,
            decoration: const InputDecoration(
                hintText: 'Write something', border: InputBorder.none),
          ),
        )
      ],
    );
  }

  _update(String _) {
    setState(() {});
  }
}

showReplyModal(BuildContext context) {
  final theme = Theme.of(context);
  final sheetController = SheetController();
  const iconSize = 25.0;

  showSlidingBottomSheet(context, builder: (BuildContext context) {
    return SlidingSheetDialog(
        headerBuilder: (context, _) {
          bool shouldExpand() {
            final state = sheetController.state;
            if (state == null) return false;
            return state.isCollapsed;
          }

          return Material(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      if (shouldExpand()) {
                        sheetController.expand();
                      } else {
                        sheetController.collapse();
                      }
                    },
                    icon: const Icon(CupertinoIcons.fullscreen)),
              ]));
        },
        footerBuilder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                RoundedElevatedButton(
                  title: 'Post',
                  onPressed: () {},
                ),
              ]),
            ),
        controller: sheetController,
        backdropColor: Colors.transparent,
        elevation: 16.0,
        cornerRadius: 16.0,
        duration: const Duration(milliseconds: 250),
        color: theme.scaffoldBackgroundColor,
        snapSpec: const SnapSpec(snappings: [0.4, 0.7, 1.0]),
        builder: (context, __) => ReplyModal(sheetController: sheetController));
  });
}
