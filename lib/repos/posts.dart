import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username, body;
  final DateTime timestamp;
  final String? uid, parentUid;
  Post({
    required this.username,
    required this.body,
    this.uid,
    this.parentUid,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get isRoot => parentUid == null;
  bool get isChild => !isRoot;
  List<Post> children = [];

  Post.fromJson(Map<String, dynamic> json)
      : this(
            username: json['username'],
            body: json['body'],
            uid: json['uid'],
            parentUid: json['parent_uid'],
            timestamp: DateTime.parse(json['timestamp']));

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'body': body,
      'uid': uid,
      'parent_uid': parentUid,
      'timestamp': timestamp.toIso8601String()
    };
  }
}

abstract class PostsRepo {
  static const collectionKey = 'posts';
  Future<Post?> getById(String docId);
  Future<void> add(Post post);
  Future<List<Post>> getAll();
  Future<List<Post>> getAllByUsername(String username);
  List<Post> buildCommentTree(List<Post> posts);
}

class FirestorePostsRepo implements PostsRepo {
  late final CollectionReference<Post> _collection;
  FirestorePostsRepo() {
    _collection = FirebaseFirestore.instance
        .collection(PostsRepo.collectionKey)
        .withConverter<Post>(
            fromFirestore: (snapshot, _) {
              final map = snapshot.data()!;
              map['uid'] = snapshot.reference.id;
              return Post.fromJson(map);
            },
            toFirestore: (post, _) => post.toJson());
  }

  @override
  getById(String docId) async {
    final snapshot = await _collection.doc(docId).get();
    return snapshot.data();
  }

  @override
  add(Post post) async {
    await _collection.add(post);
  }

  @override
  getAll() async {
    final querySnapshot = await _collection
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();

    final posts =
        querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return posts;
  }

  @override
  List<Post> buildCommentTree(List<Post> posts) {
    final childrenMap = HashMap<String, List<Post>>();
    final tree = <Post>[];
    for (final post in posts) {
      if (post.uid == null) continue;
      post.children = childrenMap.putIfAbsent(post.uid!, () => post.children);
      if (post.isRoot) {
        tree.add(post);
      } else {
        final parent = childrenMap.putIfAbsent(post.parentUid!, () => []);
        parent.add(post);
      }
    }
    return tree;
  }

  @override
  getAllByUsername(String username) async {
    final querySnapshot = await _collection
        .where('username', isEqualTo: username)
        .orderBy('timestamp', descending: true)
        .get();
    final posts =
        querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return posts;
  }
}
