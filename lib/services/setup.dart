import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/firebase_options.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';
import 'package:moments/services/deep_link_listener.dart';
import 'package:moments/util/unauth_guard.dart';

setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterFireUIAuth.configureProviders(
      [DefaultFirebaseOptions.emailLinkProviderConfig]);

  final auth = FirebaseAuthService();
  await auth.init();
  GetIt.I.registerSingleton<AuthService>(auth);

  final router = AppRouter(
    unauthGuard: UnauthGuard(),
  );
  GetIt.I.registerSingleton<AppRouter>(router);

  await listenForDeepLinks();
}
