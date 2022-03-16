import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/posts.dart';

abstract class FeedService extends ChangeNotifier {
  Future<List<Post>> getAll();
  Future<void> add(String title, String body);

  List<Post> _posts = [];
  List<Post> get posts => UnmodifiableListView(_posts);
}

class FirestoreFeedService extends FeedService {
  final _collection = GetIt.I<PostsRepo>();
  @override
  Future<List<Post>> getAll() async {
    notifyListeners();
    _posts = await _collection.getAll();
    notifyListeners();
    return posts;
  }

  @override
  Future<Post> add(String title, String body) async {
    final post = Post(title: title, body: body);
    await _collection.add(post);
    notifyListeners();
    return post;
  }
}
