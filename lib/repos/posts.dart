import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Post {
  final String title, body;
  final DateTime timestamp;
  Post({required this.title, required this.body, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  Post.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            body: json['body'],
            timestamp: DateTime.parse(json['timestamp']));

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String()
    };
  }
}

abstract class PostsRepo {
  static const collectionKey = 'posts';
  Future<Post?> getById(String docId);
  Future<void> add(Post post);
  Future<List<Post>> getAll();
}

class FirebasePostsRepo extends PostsRepo {
  late final CollectionReference<Post> _collection;
  FirebasePostsRepo() {
    _collection = FirebaseFirestore.instance
        .collection(PostsRepo.collectionKey)
        .withConverter<Post>(
            fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
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
        .orderBy('timestamp', descending: false)
        .limit(10)
        .get();
    final posts =
        querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return posts;
  }
}
