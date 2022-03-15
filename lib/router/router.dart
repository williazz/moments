import 'package:auto_route/auto_route.dart';
import 'package:moments/util/unauth_guard.dart';
import 'package:moments/views/feed_page.dart';
import 'package:moments/views/home_page.dart';
import 'package:moments/views/onboarding/link_sent_page.dart';
import 'package:moments/views/onboarding/login_page.dart';
import 'package:moments/views/not_found.dart';
import 'package:moments/views/you_page.dart';

import 'config.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
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
              AutoRoute(path: '*', page: NotFoundPage),
            ]),
        AutoRoute(
            path: Path.you,
            name: Routers.you,
            page: EmptyRouterPage,
            children: [
              AutoRoute(path: '', page: YouPage),
              AutoRoute(path: '*', page: NotFoundPage),
            ]),
      ],
    ),
    AutoRoute(path: '*', page: NotFoundPage),
  ],
)
class $AppRouter {}
