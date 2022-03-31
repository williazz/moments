import 'package:flutter/material.dart';

showDangerDialog(
  BuildContext context,
  Function onConfirm,
) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    onPressed: () => onConfirm(),
                    child:
                        const Text('Yes', style: TextStyle(color: Colors.red))),
              ],
            )
          ],
        );
      });
}
