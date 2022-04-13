import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool outlined;
  RoundedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.outlined = false,
  }) : super(key: key);

  final _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));

  @override
  Widget build(BuildContext context) {
    return outlined
        ? OutlinedButton(
            onPressed: onPressed, style: _buttonStyle, child: Text(title))
        : ElevatedButton(
            style: _buttonStyle, onPressed: onPressed, child: Text(title));
  }
}
