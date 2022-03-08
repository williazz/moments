import 'package:flutter/foundation.dart';

@immutable
abstract class Path {
  static const home = 'home';
  static const auth = 'auth';

  static const login = 'login';
  static const linkSent = 'linkSent/:email';
}

@immutable
abstract class RouterName {
  static const auth = 'AuthRouter';
}
