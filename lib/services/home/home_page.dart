import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(
              onPressed: () async {
                await auth.signOut();
                AutoRouter.of(context).replaceAll(const [
                  AuthRouter(children: [LoginRoute()])
                ]);
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
