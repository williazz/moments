import 'package:flutter/foundation.dart';

@immutable
abstract class Path {
  static const home = 'home';

  static const feed = 'feed';
  static const you = 'you';
  static const search = 'search';

  static const auth = 'auth';
  static const login = 'login';
  static const linkSent = 'linkSent/:email';
}

@immutable
abstract class Routers {
  static const home = 'HomeRouter';
  static const auth = 'AuthRouter';

  static const feed = 'FeedRouter';
  static const search = 'SearchRouter';
  static const you = 'YouRouter';
}
