// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i10;

import '../util/unauth_guard.dart' as _i11;
import '../util/unregistered_guard.dart' as _i12;
import '../views/auth/link_sent_page.dart' as _i5;
import '../views/auth/login_page.dart' as _i4;
import '../views/home/feed_page.dart' as _i7;
import '../views/home/home_page.dart' as _i2;
import '../views/home/profile_page.dart' as _i8;
import '../views/home/you_page.dart' as _i9;
import '../views/not_found.dart' as _i3;
import '../views/register/pick_username.dart' as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
      required this.unauthGuard,
      required this.unregisteredGuard})
      : super(navigatorKey);

  final _i11.UnauthGuard unauthGuard;

  final _i12.UnregisteredGuard unregisteredGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    RegisterRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    HomeRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    NotFoundRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.NotFoundPage());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.LoginPage());
    },
    LinkSentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LinkSentRouteArgs>(
          orElse: () =>
              LinkSentRouteArgs(email: pathParams.getString('email')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.LinkSentPage(key: args.key, email: args.email));
    },
    PickUsernameRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.PickUsernamePage());
    },
    FeedRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    YouRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    FeedRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.FeedPage());
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () =>
              ProfileRouteArgs(username: pathParams.getString('username')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.ProfilePage(key: args.key, username: args.username));
    },
    YouRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.YouPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'auth', fullMatch: true),
        _i1.RouteConfig(AuthRouter.name, path: 'auth', guards: [
          unauthGuard
        ], children: [
          _i1.RouteConfig('#redirect',
              path: '',
              parent: AuthRouter.name,
              redirectTo: 'login',
              fullMatch: true),
          _i1.RouteConfig(LoginRoute.name,
              path: 'login', parent: AuthRouter.name),
          _i1.RouteConfig(LinkSentRoute.name,
              path: 'linkSent/:email', parent: AuthRouter.name),
          _i1.RouteConfig(NotFoundRoute.name,
              path: '*', parent: AuthRouter.name)
        ]),
        _i1.RouteConfig(RegisterRouter.name, path: 'register', guards: [
          unregisteredGuard
        ], children: [
          _i1.RouteConfig('#redirect',
              path: '',
              parent: RegisterRouter.name,
              redirectTo: 'username',
              fullMatch: true),
          _i1.RouteConfig(PickUsernameRoute.name,
              path: 'username', parent: RegisterRouter.name)
        ]),
        _i1.RouteConfig(HomeRouter.name, path: 'home', children: [
          _i1.RouteConfig(FeedRouter.name,
              path: 'feed',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(FeedRoute.name,
                    path: '', parent: FeedRouter.name),
                _i1.RouteConfig(ProfileRoute.name,
                    path: 'user/:username', parent: FeedRouter.name),
                _i1.RouteConfig(NotFoundRoute.name,
                    path: '*', parent: FeedRouter.name)
              ]),
          _i1.RouteConfig(YouRouter.name,
              path: 'you',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(YouRoute.name,
                    path: '', parent: YouRouter.name),
                _i1.RouteConfig(ProfileRoute.name,
                    path: 'user/:username', parent: YouRouter.name),
                _i1.RouteConfig(NotFoundRoute.name,
                    path: '*', parent: YouRouter.name)
              ])
        ]),
        _i1.RouteConfig(NotFoundRoute.name, path: '*')
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthRouter extends _i1.PageRouteInfo<void> {
  const AuthRouter({List<_i1.PageRouteInfo>? children})
      : super(AuthRouter.name, path: 'auth', initialChildren: children);

  static const String name = 'AuthRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class RegisterRouter extends _i1.PageRouteInfo<void> {
  const RegisterRouter({List<_i1.PageRouteInfo>? children})
      : super(RegisterRouter.name, path: 'register', initialChildren: children);

  static const String name = 'RegisterRouter';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i1.PageRouteInfo<void> {
  const HomeRouter({List<_i1.PageRouteInfo>? children})
      : super(HomeRouter.name, path: 'home', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.NotFoundPage]
class NotFoundRoute extends _i1.PageRouteInfo<void> {
  const NotFoundRoute() : super(NotFoundRoute.name, path: '*');

  static const String name = 'NotFoundRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.LinkSentPage]
class LinkSentRoute extends _i1.PageRouteInfo<LinkSentRouteArgs> {
  LinkSentRoute({_i10.Key? key, required String email})
      : super(LinkSentRoute.name,
            path: 'linkSent/:email',
            args: LinkSentRouteArgs(key: key, email: email),
            rawPathParams: {'email': email});

  static const String name = 'LinkSentRoute';
}

class LinkSentRouteArgs {
  const LinkSentRouteArgs({this.key, required this.email});

  final _i10.Key? key;

  final String email;

  @override
  String toString() {
    return 'LinkSentRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i6.PickUsernamePage]
class PickUsernameRoute extends _i1.PageRouteInfo<void> {
  const PickUsernameRoute() : super(PickUsernameRoute.name, path: 'username');

  static const String name = 'PickUsernameRoute';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class FeedRouter extends _i1.PageRouteInfo<void> {
  const FeedRouter({List<_i1.PageRouteInfo>? children})
      : super(FeedRouter.name, path: 'feed', initialChildren: children);

  static const String name = 'FeedRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class YouRouter extends _i1.PageRouteInfo<void> {
  const YouRouter({List<_i1.PageRouteInfo>? children})
      : super(YouRouter.name, path: 'you', initialChildren: children);

  static const String name = 'YouRouter';
}

/// generated route for
/// [_i7.FeedPage]
class FeedRoute extends _i1.PageRouteInfo<void> {
  const FeedRoute() : super(FeedRoute.name, path: '');

  static const String name = 'FeedRoute';
}

/// generated route for
/// [_i8.ProfilePage]
class ProfileRoute extends _i1.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i10.Key? key, required String username})
      : super(ProfileRoute.name,
            path: 'user/:username',
            args: ProfileRouteArgs(key: key, username: username),
            rawPathParams: {'username': username});

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, required this.username});

  final _i10.Key? key;

  final String username;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i9.YouPage]
class YouRoute extends _i1.PageRouteInfo<void> {
  const YouRoute() : super(YouRoute.name, path: '');

  static const String name = 'YouRoute';
}
