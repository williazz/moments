import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/signout_button.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<AuthService>(
              builder: (_, auth, __) =>
                  Text('Authenticated: ${auth.isAuthenticated}')),
          const SignoutButton(),
          ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const AuthRouter());
              },
              child: const Text('Open Auth Modal')),
        ],
      ),
    );
  }
}
