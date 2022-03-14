import 'package:auto_route/auto_route.dart';
import 'package:moments/views/feed_page.dart';
import 'package:moments/views/home_page.dart';
import 'package:moments/views/onboarding/link_sent_page.dart';
import 'package:moments/views/onboarding/login_page.dart';
import 'package:moments/views/not_found.dart';
import 'package:moments/views/search_page.dart';
import 'package:moments/views/you_page.dart';

import 'config.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(initial: true, path: Path.home, page: HomePage, children: [
      AutoRoute(
          // initial: true,
          path: Path.feed,
          name: Routers.feed,
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, path: '', page: FeedPage),
            AutoRoute(path: '*', page: NotFoundPage),
          ]),
      AutoRoute(
          path: Path.search,
          name: Routers.search,
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, path: '', page: SearchPage),
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
    ]),
    AutoRoute(
        initial: true,
        fullscreenDialog: true,
        name: Routers.auth,
        path: Path.auth,
        page: EmptyRouterPage,
        children: [
          AutoRoute(
              initial: true,
              fullscreenDialog: true,
              path: Path.login,
              page: LoginPage),
          AutoRoute(
              path: Path.linkSent, fullscreenDialog: true, page: LinkSentPage),
        ]),
    AutoRoute(path: '*', page: NotFoundPage),
  ],
)
class $AppRouter {}
