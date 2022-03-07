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
import 'package:flutter/material.dart' as _i5;

import '../services/auth/pages/link_sent.dart' as _i4;
import '../services/auth/pages/login_page.dart' as _i3;
import '../services/not_found.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    EmptyRouterRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    NotFoundRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NotFoundPage());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    LinkSentRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LinkSentRouteArgs>(
          orElse: () =>
              LinkSentRouteArgs(email: pathParams.getString('email')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.LinkSentPage(key: args.key, email: args.email));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'auth', fullMatch: true),
        _i1.RouteConfig(EmptyRouterRoute.name, path: 'auth', children: [
          _i1.RouteConfig('#redirect',
              path: '',
              parent: EmptyRouterRoute.name,
              redirectTo: 'login',
              fullMatch: true),
          _i1.RouteConfig(LoginRoute.name,
              path: 'login', parent: EmptyRouterRoute.name),
          _i1.RouteConfig(LinkSentRoute.name,
              path: 'linkSent/:email', parent: EmptyRouterRoute.name)
        ]),
        _i1.RouteConfig(NotFoundRoute.name, path: '*')
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class EmptyRouterRoute extends _i1.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i1.PageRouteInfo>? children})
      : super(EmptyRouterRoute.name, path: 'auth', initialChildren: children);

  static const String name = 'EmptyRouterRoute';
}

/// generated route for
/// [_i2.NotFoundPage]
class NotFoundRoute extends _i1.PageRouteInfo<void> {
  const NotFoundRoute() : super(NotFoundRoute.name, path: '*');

  static const String name = 'NotFoundRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.LinkSentPage]
class LinkSentRoute extends _i1.PageRouteInfo<LinkSentRouteArgs> {
  LinkSentRoute({_i5.Key? key, required String email})
      : super(LinkSentRoute.name,
            path: 'linkSent/:email',
            args: LinkSentRouteArgs(key: key, email: email),
            rawPathParams: {'email': email});

  static const String name = 'LinkSentRoute';
}

class LinkSentRouteArgs {
  const LinkSentRouteArgs({this.key, required this.email});

  final _i5.Key? key;

  final String email;

  @override
  String toString() {
    return 'LinkSentRouteArgs{key: $key, email: $email}';
  }
}
