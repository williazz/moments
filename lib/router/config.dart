import 'package:flutter/foundation.dart';

@immutable
abstract class Path {
  static const home = '/';
  static const auth = 'auth';

  static const login = 'login';
  static const linkSent = 'linkSent/:email';
}
