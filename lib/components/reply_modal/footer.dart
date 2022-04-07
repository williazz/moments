import 'package:flutter/material.dart';

class ReplyFooterWidget extends StatefulWidget {
  const ReplyFooterWidget({Key? key}) : super(key: key);

  @override
  State<ReplyFooterWidget> createState() => ReplyFooterWidgetState();
}

class ReplyFooterWidgetState extends State<ReplyFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: () {}, child: const Text('Post')),
      ],
    );
  }
}
