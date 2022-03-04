import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:moments/firebase_options.dart';

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    EmailLinkProviderConfiguration(
        actionCodeSettings: ActionCodeSettings(
            url: 'https://bigmoments.page.link/test',
            handleCodeInApp: true,
            iOSBundleId: 'com.moments.williazz')),
  ]);
}
