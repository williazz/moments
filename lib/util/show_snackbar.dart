import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String title) {
  final controller = ScaffoldMessenger.of(context);
  controller.hideCurrentSnackBar();
  controller.showSnackBar(SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: controller.hideCurrentSnackBar,
      )));
}
