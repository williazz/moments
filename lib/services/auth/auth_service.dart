import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<void> signInWithEmailLink(String email);
}

class FirebaseAuthService extends AuthService {
  @override
  Future<void> signInWithEmailLink(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    throw FirebaseAuthException(code: '404');
  }
}
