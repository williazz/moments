import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moments/firebase_options.dart';

abstract class AuthService extends ChangeNotifier {
  Future<void> sendSignInLinkToEmail(String email);
  Future<void> signOut();
}

class FirebaseAuthService extends AuthService {
  @override
  Future<void> sendSignInLinkToEmail(String email) async {
    await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: DefaultFirebaseOptions.emailLinkSettings);
  }

  @override
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
