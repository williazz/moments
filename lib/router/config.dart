import 'package:flutter/foundation.dart';

@immutable
abstract class Path {
  static const home = 'home';
  static const feed = 'feed';
  static const you = 'you';
  static const createPost = 'createPost';

  static const auth = 'auth';
  static const login = 'login';
  static const linkSent = 'linkSent/:email';

  static const register = 'register';
  static const username = 'username';
}

@immutable
abstract class Routers {
  static const home = 'HomeRouter';
  static const auth = 'AuthRouter';
  static const register = 'RegisterRouter';

  static const feed = 'FeedRouter';
  static const you = 'YouRouter';
}
