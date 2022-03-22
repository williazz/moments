import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserDetails {
  final String username, uuid;
  const UserDetails({
    required this.uuid,
    required this.username,
  });

  UserDetails.fromJson(Map<String, dynamic> json)
      : this(uuid: json['uuid'], username: json['username']);

  Map<String, dynamic> toJson() => {'uuid': uuid, 'username': username};
}

abstract class UsersRepo {
  static const collectionKey = 'user-details';
  Future<UserDetails?> getByUUID(String uuid);
  Future<void> create(UserDetails user);
}

class FirestoreUsersRepo extends UsersRepo {
  late final CollectionReference<UserDetails> _collection;

  FirestoreUsersRepo() {
    _collection = FirebaseFirestore.instance
        .collection(UsersRepo.collectionKey)
        .withConverter<UserDetails>(
            fromFirestore: (snapshot, _) =>
                UserDetails.fromJson(snapshot.data()!),
            toFirestore: (userDetails, _) => userDetails.toJson());
  }

  @override
  create(UserDetails user) async {
    await _collection.add(user);
  }

  @override
  getByUUID(String uuid) async {
    final snapshot =
        await _collection.limit(1).where('uuid', isEqualTo: uuid).get();
    return snapshot.docs.isEmpty ? null : snapshot.docs[0].data();
  }
}
