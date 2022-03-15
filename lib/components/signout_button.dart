import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';

class SignoutButton extends StatefulWidget {
  const SignoutButton({Key? key}) : super(key: key);

  @override
  State<SignoutButton> createState() => _SignoutButtonState();
}

class _SignoutButtonState extends State<SignoutButton> {
  final _auth = GetIt.I<AuthService>();
  bool _locked = false;
  bool get locked => _locked;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: locked ? null : _signout,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Sign Out'),
        ));
  }

  final _router = GetIt.I<AppRouter>();
  _signout() async {
    if (locked) return;
    setState(() => _locked = true);
    await _auth.signOut();
    _router.replaceAll(const [AuthRouter()]);
    setState(() => _locked = false);
  }
}
