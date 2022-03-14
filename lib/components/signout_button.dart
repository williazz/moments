import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I<AuthService>();

    return OutlinedButton(
        onPressed: () async {
          await auth.signOut();
          AutoRouter.of(context).replaceAll(const [
            AuthRouter(children: [LoginRoute()])
          ]);
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Sign Out'),
        ));
  }
}
