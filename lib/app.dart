import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart'
    show ProfileScreen, EmailLinkSignInView, EmailLinkProviderConfiguration;

class MomentsApp extends StatelessWidget {
  const MomentsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moments',
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        }
        return const HomePage();
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmailLinkSignInView(
                config: EmailLinkProviderConfiguration(
                    actionCodeSettings: ActionCodeSettings(
                        url: 'https://bigmoments.page.link/test',
                        handleCodeInApp: true,
                        iOSBundleId: 'com.moments.williazz'))),
            const Text('Another child'),
          ],
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
