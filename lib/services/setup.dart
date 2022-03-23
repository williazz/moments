import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/firebase_options.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/repos/profiles.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/feed.dart';
import 'package:moments/services/register.dart';
import 'package:moments/util/unauth_guard.dart';
import 'package:moments/util/unregistered_guard.dart';

import 'auth.dart';
import 'deep_link_listener.dart';

setup() async {
  // pre-setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterFireUIAuth.configureProviders(
      [DefaultFirebaseOptions.emailLinkProviderConfig]);

  // repos
  GetIt.I.registerSingleton<PostsRepo>(FirestorePostsRepo());
  GetIt.I.registerSingleton<ProfilesRepo>(FirestoreProfilesRepo());

  // services
  GetIt.I.registerSingleton<AuthService>(await FirebaseAuthService().init());
  GetIt.I.registerSingleton<RegisterService>(FirestoreRegisterService());
  GetIt.I.registerSingleton<FeedService>(FirestoreFeedService());

  // router
  GetIt.I.registerSingleton<AppRouter>(AppRouter(
    unauthGuard: UnauthGuard(),
    unregisteredGuard: UnregisteredGuard(),
  ));
  await listenForDeepLinks();
}
