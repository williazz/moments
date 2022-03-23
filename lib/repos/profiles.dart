import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Profile {
  final String username, uuid;
  const Profile({
    required this.uuid,
    required this.username,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : this(uuid: json['uuid'], username: json['username']);

  Map<String, dynamic> toJson() => {'uuid': uuid, 'username': username};
}

abstract class UsersRepo {
  static const collectionKey = 'profiles';
  Future<Profile?> getByUUID(String uuid);
  Future<void> create(Profile user);
  Future<bool> isRegistered(String uuid) async {
    final user = await getByUUID(uuid);
    return user != null;
  }
}

class FirestoreUsersRepo extends UsersRepo {
  late final CollectionReference<Profile> _collection;

  FirestoreUsersRepo() {
    _collection = FirebaseFirestore.instance
        .collection(UsersRepo.collectionKey)
        .withConverter<Profile>(
            fromFirestore: (snapshot, _) => Profile.fromJson(snapshot.data()!),
            toFirestore: (profile, _) => profile.toJson());
  }

  @override
  create(Profile user) async {
    await _collection.add(user);
  }

  @override
  getByUUID(String uuid) async {
    final snapshot =
        await _collection.limit(1).where('uuid', isEqualTo: uuid).get();
    return snapshot.docs.isEmpty ? null : snapshot.docs[0].data();
  }
}
