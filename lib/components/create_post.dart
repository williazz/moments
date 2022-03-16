import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/rounded_elevated_button.dart';

class CreatePostModal extends StatelessWidget {
  const CreatePostModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _customAppBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customAppBar(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  }),
              RoundedElevatedButton(title: 'Post', onPressed: () {}),
            ]));
  }
}
