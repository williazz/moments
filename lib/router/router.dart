import 'package:auto_route/auto_route.dart';
import 'package:moments/components/create_post.dart';
import 'package:moments/util/unauth_guard.dart';
import 'package:moments/views/auth/link_sent_page.dart';
import 'package:moments/views/auth/login_page.dart';
import 'package:moments/views/home/feed_page.dart';
import 'package:moments/views/home/home_page.dart';
import 'package:moments/views/home/you_page.dart';
import 'package:moments/views/not_found.dart';
import 'package:moments/views/register/choose_username.dart';

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
        children: [
          AutoRoute(initial: true, path: Path.username, page: UsernamePage),
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
              AutoRoute(
                  path: Path.createPost,
                  fullscreenDialog: true,
                  page: CreatePostModal),
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
