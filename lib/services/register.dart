import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/profiles.dart';
import 'package:moments/services/auth.dart';

abstract class RegisterService extends ChangeNotifier {
  final usernameController = TextEditingController();
  Future<bool> get isRegistered;
  Future<void> register(Profile profile);
  Future<bool> usernameIsAvailable(String username);
}

class FirestoreRegisterService extends RegisterService {
  final _auth = GetIt.I<AuthService>();
  final _profiles = GetIt.I<ProfilesRepo>();

  @override
  Future<bool> get isRegistered async {
    if (!_auth.isAuthenticated) return false;
    final uuid = _auth.user!.uid;
    return await _profiles.exists(uuid);
  }

  @override
  Future<void> register(Profile profile) async {
    await _profiles.create(profile);
  }

  @override
  Future<bool> usernameIsAvailable(String username) async {
    final res = await _profiles.usernameIsAvailable(username);
    return res;
  }
}
