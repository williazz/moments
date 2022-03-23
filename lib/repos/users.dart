import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String username, uuid;
  const UserModel({
    required this.uuid,
    required this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(uuid: json['uuid'], username: json['username']);

  Map<String, dynamic> toJson() => {'uuid': uuid, 'username': username};
}

abstract class UsersRepo {
  static const collectionKey = 'user-details';
  Future<UserModel?> getByUUID(String uuid);
  Future<void> create(UserModel user);
  Future<bool> isRegistered(String uuid) async {
    final user = await getByUUID(uuid);
    return user != null;
  }
}

class FirestoreUsersRepo extends UsersRepo {
  late final CollectionReference<UserModel> _collection;

  FirestoreUsersRepo() {
    _collection = FirebaseFirestore.instance
        .collection(UsersRepo.collectionKey)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  @override
  create(UserModel user) async {
    await _collection.add(user);
  }

  @override
  getByUUID(String uuid) async {
    final snapshot =
        await _collection.limit(1).where('uuid', isEqualTo: uuid).get();
    return snapshot.docs.isEmpty ? null : snapshot.docs[0].data();
  }
}
