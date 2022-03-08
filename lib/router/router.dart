import 'package:auto_route/auto_route.dart';
import 'package:moments/services/auth/pages/link_sent.dart';
import 'package:moments/services/auth/pages/login_page.dart';
import 'package:moments/services/home/home_page.dart';
import 'package:moments/services/not_found.dart';

import 'config.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      path: Path.home,
      page: HomePage,
    ),
    AutoRoute(
      name: RouterName.auth,
      path: Path.auth,
      page: EmptyRouterPage,
      children: [
        AutoRoute(initial: true, path: Path.login, page: LoginPage),
        AutoRoute(path: Path.linkSent, page: LinkSentPage),
      ],
    ),
    AutoRoute(
      path: '*',
      page: NotFoundPage,
    ),
  ],
)
class $AppRouter {}
