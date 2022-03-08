import 'package:flutter/material.dart';

showAlertDialog(
    {required BuildContext context, required String title, String? content}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: content == null ? null : Text(content),
        );
      });
}
