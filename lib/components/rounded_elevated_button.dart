import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const RoundedElevatedButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))),
        onPressed: onPressed,
        child: Text(title));
  }
}
