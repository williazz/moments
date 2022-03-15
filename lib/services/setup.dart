import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/firebase_options.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/feed.dart';
import 'package:moments/util/unauth_guard.dart';

import 'auth.dart';
import 'deep_link_listener.dart';

setup() async {
  // pre-setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterFireUIAuth.configureProviders(
      [DefaultFirebaseOptions.emailLinkProviderConfig]);
  final getIt = GetIt.I;

  // repos
  getIt.registerSingleton<PostsRepo>(FirestorePostsRepo());

  // services
  final auth = FirebaseAuthService();
  await auth.init();
  getIt.registerSingleton<AuthService>(auth);
  getIt.registerSingleton<FeedService>(FirestoreFeedService());

  // router
  final router = AppRouter(
    unauthGuard: UnauthGuard(),
  );
  getIt.registerSingleton<AppRouter>(router);
  await listenForDeepLinks();
}
