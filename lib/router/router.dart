import 'package:auto_route/auto_route.dart';
import 'package:moments/views/home/home_page.dart';
import 'package:moments/views/onboarding/link_sent_page.dart';
import 'package:moments/views/onboarding/login_page.dart';
import 'package:moments/views/not_found.dart';

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
