import 'package:flutter/material.dart';

final momentsTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.green,
    accentColor: Colors.blue,
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    errorColor: Colors.red,
    brightness: Brightness.light,
  ),
);

const darkTheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.green,
  onPrimary: Colors.white,
  secondary: Colors.blue,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.black,
  onSurface: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
);
