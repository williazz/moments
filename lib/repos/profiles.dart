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

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'username': username,
      };
}

abstract class ProfilesRepo {
  static const collectionKey = 'profiles';
  Future<Profile?> getByUUID(String uuid);
  Future<void> create(Profile profile);
  Future<bool> usernameIsAvailable(String username);

  Future<bool> exists(String uuid) async {
    final user = await getByUUID(uuid);
    return user != null;
  }
}

class FirestoreProfilesRepo extends ProfilesRepo {
  late final CollectionReference<Profile> _collection;

  FirestoreProfilesRepo() {
    _collection = FirebaseFirestore.instance
        .collection(ProfilesRepo.collectionKey)
        .withConverter<Profile>(
            fromFirestore: (snapshot, _) => Profile.fromJson(snapshot.data()!),
            toFirestore: (profile, _) => profile.toJson());
  }

  @override
  create(Profile profile) async {
    if (await usernameIsAvailable(profile.username)) {
      await _collection.doc(profile.uuid).set(profile);
    } else {
      throw Exception('Username already exists');
    }
  }

  @override
  getByUUID(String uuid) async {
    final snapshot =
        await _collection.limit(1).where('uuid', isEqualTo: uuid).get();
    return snapshot.docs.isEmpty ? null : snapshot.docs[0].data();
  }

  @override
  Future<bool> usernameIsAvailable(String username) async {
    final snapshot =
        await _collection.limit(1).where('username', isEqualTo: username).get();
    return snapshot.docs.isEmpty;
  }
}
