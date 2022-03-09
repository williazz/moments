// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i6;

import '../services/auth/pages/link_sent.dart' as _i5;
import '../services/auth/pages/login_page.dart' as _i4;
import '../services/home/home_page.dart' as _i1;
import '../services/not_found.dart' as _i3;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    AuthRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    NotFoundRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.NotFoundPage());
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.LoginPage());
    },
    LinkSentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LinkSentRouteArgs>(
          orElse: () =>
              LinkSentRouteArgs(email: pathParams.getString('email')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.LinkSentPage(key: args.key, email: args.email));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        _i2.RouteConfig(HomeRoute.name, path: 'home'),
        _i2.RouteConfig(AuthRouter.name, path: 'auth', children: [
          _i2.RouteConfig('#redirect',
              path: '',
              parent: AuthRouter.name,
              redirectTo: 'login',
              fullMatch: true),
          _i2.RouteConfig(LoginRoute.name,
              path: 'login', parent: AuthRouter.name),
          _i2.RouteConfig(LinkSentRoute.name,
              path: 'linkSent/:email', parent: AuthRouter.name)
        ]),
        _i2.RouteConfig(NotFoundRoute.name, path: '*')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class AuthRouter extends _i2.PageRouteInfo<void> {
  const AuthRouter({List<_i2.PageRouteInfo>? children})
      : super(AuthRouter.name, path: 'auth', initialChildren: children);

  static const String name = 'AuthRouter';
}

/// generated route for
/// [_i3.NotFoundPage]
class NotFoundRoute extends _i2.PageRouteInfo<void> {
  const NotFoundRoute() : super(NotFoundRoute.name, path: '*');

  static const String name = 'NotFoundRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.LinkSentPage]
class LinkSentRoute extends _i2.PageRouteInfo<LinkSentRouteArgs> {
  LinkSentRoute({_i6.Key? key, required String email})
      : super(LinkSentRoute.name,
            path: 'linkSent/:email',
            args: LinkSentRouteArgs(key: key, email: email),
            rawPathParams: {'email': email});

  static const String name = 'LinkSentRoute';
}

class LinkSentRouteArgs {
  const LinkSentRouteArgs({this.key, required this.email});

  final _i6.Key? key;

  final String email;

  @override
  String toString() {
    return 'LinkSentRouteArgs{key: $key, email: $email}';
  }
}
