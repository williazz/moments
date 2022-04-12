import 'package:flutter/material.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';

class ReplyFooterWidget extends StatefulWidget {
  const ReplyFooterWidget({Key? key}) : super(key: key);

  @override
  State<ReplyFooterWidget> createState() => ReplyFooterWidgetState();
}

class ReplyFooterWidgetState extends State<ReplyFooterWidget> {
  late final RepliableFeedStateProvider state;

  @override
  void didChangeDependencies() {
    state = RepliableFeedStateProvider.of(context)!;
    super.didChangeDependencies();
  }

  bool posting = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ValueListenableBuilder(
            valueListenable: state.editor,
            builder: (_, editor, __) {
              final locked = state.editor.text.isEmpty || posting;
              return TextButton(
                  onPressed: locked ? null : post, child: const Text('Post'));
            }),
      ],
    );
  }

  post() async {
    if (posting) return;
    setState(() => posting = true);
    await state.post(context);
    setState(() => posting = false);
  }
}
