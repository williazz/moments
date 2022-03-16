import 'package:flutter/material.dart';

class CreatePostModal extends StatelessWidget {
  const CreatePostModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: TextButton(child: const Text('Cancel'), onPressed: () {}),
          // actions: [
          //   ElevatedButton(onPressed: () {}, child: const Text('Post')),
          // ],
          ),
      body: Container(color: Colors.red),
    );
  }
}
