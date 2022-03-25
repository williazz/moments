import 'dart:collection';

import 'package:dcache/dcache.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/posts.dart';

abstract class FeedService extends ChangeNotifier {
  Future<List<Post>> getAll();
  Future<void> add(Post post);
  List<Post> _posts = [];
  List<Post> get posts => UnmodifiableListView(_posts);
  Future<List<Post>> getSnapshotByProfile(String username,
      {bool update = false});
}

class FirestoreFeedService extends FeedService {
  final _collection = GetIt.I<PostsRepo>();
  final _cache = SimpleCache<String, List<Post>>(
      storage: InMemoryStorage<String, List<Post>>(20));

  @override
  Future<List<Post>> getAll() async {
    notifyListeners();
    _posts = await _collection.getAll();
    notifyListeners();
    return posts;
  }

  @override
  Future<Post> add(Post post) async {
    await _collection.add(post);
    _posts.insert(0, post);
    notifyListeners();
    return post;
  }

  @override
  getSnapshotByProfile(String username, {bool update = false}) async {
    if (!update && _cache.containsKey(username)) {
      return _cache.get(username)!;
    }
    final feed = await _collection.getAllByUsername(username);
    _cache.set(username, feed);
    notifyListeners();
    return feed;
  }
}
