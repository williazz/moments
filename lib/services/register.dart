import 'package:flutter/material.dart';

abstract class RegisterService extends ChangeNotifier {
  Future<bool> get isRegistered;
}
