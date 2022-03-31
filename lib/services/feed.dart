import 'dart:collection';

import 'package:dcache/dcache.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/posts.dart';

abstract class FeedService extends ChangeNotifier {
  List<Post> _home = [];
  List<Post> get home => UnmodifiableListView(_home);
  List<Post> getByUsername(String username);
  Future<void> refresh({String? username});
  Future<void> add(Post post);
}

class FirestoreFeedService extends FeedService {
  final _collection = GetIt.I<PostsRepo>();
  final _cache = SimpleCache<String, List<Post>>(
      storage: InMemoryStorage<String, List<Post>>(20));

  @override
  Future<Post> add(Post post) async {
    await _collection.add(post);
    _home.insert(0, post);
    final username = post.username;
    if (_cache.containsKey(username)) {
      final feed = getByUsername(username);
      feed.insert(0, post);
    }
    notifyListeners();
    return post;
  }

  @override
  getByUsername(String username) {
    if (_cache.containsKey(username)) {
      return _cache.get(username)!;
    }
    return [];
  }

  @override
  Future<void> refresh({String? username}) async {
    notifyListeners();
    if (username == null) {
      _home = await _collection.getAll();
    } else {
      _cache.set(username, await _collection.getAllByUsername(username));
    }
    notifyListeners();
  }
}
