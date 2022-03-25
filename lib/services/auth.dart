import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moments/firebase_options.dart';

abstract class AuthService extends ChangeNotifier {
  final emailController = TextEditingController();

  User? get user;
  bool get isAuthenticated => user != null;

  bool _hasInit = false;
  bool get hasInit => _hasInit;

  Future<AuthService> init();

  Future<void> sendSignInLinkToEmail(String email);
  Future<void> signOut();
}

class FirebaseAuthService extends AuthService {
  final _firebase = FirebaseAuth.instance;

  @override
  User? get user => _firebase.currentUser;

  @override
  init() async {
    if (hasInit) return this;
    _hasInit = true;
    await _listenForAuthChanges();
    return this;
  }

  _listenForAuthChanges() async {
    _firebase.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

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
