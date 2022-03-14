import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitModalButton extends StatelessWidget {
  const ExitModalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          AutoRouter.of(context).pop();
        },
        icon: const Icon(CupertinoIcons.clear));
  }
}
