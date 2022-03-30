import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/profiles.dart';
import 'package:moments/services/auth.dart';

abstract class RegisterService extends ChangeNotifier {
  Future<bool> isRegistered();
  Future<void> register(String username);
  Future<bool> usernameIsAvailable(String username);
  Profile? get profile;
}

class FirestoreRegisterService extends RegisterService {
  final _auth = GetIt.I<AuthService>();
  final _profiles = GetIt.I<ProfilesRepo>();
  Profile? _profile;
  @override
  Profile? get profile => _profile;

  @override
  Future<bool> isRegistered() async {
    if (!_auth.isAuthenticated) return false;
    final uuid = _auth.user!.uid;
    _profile = await _profiles.getByUUID(uuid);
    notifyListeners();
    return profile != null;
  }

  @override
  Future<void> register(String username) async {
    if (!_auth.isAuthenticated) return;
    final uuid = _auth.user!.uid;
    await _profiles.create(Profile(uuid: uuid, username: username));
    await isRegistered();

    notifyListeners();
  }

  @override
  Future<bool> usernameIsAvailable(String username) async {
    final res = await _profiles.usernameIsAvailable(username);
    return res;
  }
}
