import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth/auth_service.dart';

import 'login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInWithEmail = GetIt.I<AuthService>().sendSignInLinkToEmail;

    return LoginScreen(
      signIn: (email) async {
        await signInWithEmail(email);
        AutoRouter.of(context).push(LinkSentRoute(email: email));
      },
    );
  }
}
