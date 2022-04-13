import 'package:auto_route/auto_route.dart';
import 'package:moments/util/unauth_guard.dart';
import 'package:moments/util/unregistered_guard.dart';
import 'package:moments/views/auth/link_sent_page.dart';
import 'package:moments/views/auth/login_page.dart';
import 'package:moments/views/home/feed_page.dart';
import 'package:moments/views/home/home_page.dart';
import 'package:moments/views/home/profile_page.dart';
import 'package:moments/views/home/you_page.dart';
import 'package:moments/views/not_found.dart';
import 'package:moments/views/register/pick_username.dart';

import 'config.dart';

@MaterialAutoRouter(
  replaceInRouteName: '(Page)|(Modal),Route',
  routes: [
    AutoRoute(
        initial: true,
        path: Path.auth,
        name: Routers.auth,
        page: EmptyRouterPage,
        guards: [
          UnauthGuard
        ],
        children: [
          AutoRoute(initial: true, path: Path.login, page: LoginPage),
          AutoRoute(path: Path.linkSent, page: LinkSentPage),
          AutoRoute(path: '*', page: NotFoundPage),
        ]),
    AutoRoute(
        path: Path.register,
        name: Routers.register,
        page: EmptyRouterPage,
        guards: [
          UnregisteredGuard
        ],
        children: [
          AutoRoute(initial: true, path: Path.username, page: PickUsernamePage),
        ]),
    AutoRoute(
      path: Path.home,
      name: Routers.home,
      page: HomePage,
      children: [
        AutoRoute(
            path: Path.feed,
            name: Routers.feed,
            page: EmptyRouterPage,
            children: [
              AutoRoute(path: '', page: FeedPage),
              AutoRoute(path: 'user/:username', page: ProfilePage),
              AutoRoute(path: '*', page: NotFoundPage),
            ]),
        AutoRoute(
            path: Path.you,
            name: Routers.you,
            page: EmptyRouterPage,
            children: [
              AutoRoute(path: '', page: YouPage),
              AutoRoute(path: 'user/:username', page: ProfilePage),
              AutoRoute(path: '*', page: NotFoundPage),
            ]),
      ],
    ),
    AutoRoute(path: '*', page: NotFoundPage),
  ],
)
class $AppRouter {}
