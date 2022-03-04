import 'package:flutter/material.dart';
import 'package:moments/app.dart';
import 'package:moments/services/setup.dart';

void main() async {
  await setup();
  runApp(const MomentsApp());
}
