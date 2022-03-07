import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/firebase_options.dart';
import 'package:moments/services/auth/auth_service.dart';

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    DefaultFirebaseOptions.emailLinkProviderConfig,
  ]);

  GetIt.I.registerSingleton<AuthService>(FirebaseAuthService());
}
