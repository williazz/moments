import 'dart:collection';

import 'package:dcache/dcache.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/repos/posts.dart';
import 'package:moments/services/register.dart';

abstract class FeedService extends ChangeNotifier {
  List<Post> _home = [];
  List<Post> get home => UnmodifiableListView(_home);
  List<Post> getByUsername(String username);
  Future<void> refresh({String? username});
  Future<Post> add(String body);
  Future<Post> reply(String body, Post parent);
}

class FirestoreFeedService extends FeedService {
  final _register = GetIt.I<RegisterService>();
  final _collection = GetIt.I<PostsRepo>();
  final _cache = SimpleCache<String, List<Post>>(
      storage: InMemoryStorage<String, List<Post>>(20));
  String get username => _register.profile!.username;

  @override
  add(String body) async {
    final post = Post(username: username, body: body);
    final postWithUid = await _collection.add(post);
    _home.insert(0, postWithUid);
    if (_cache.containsKey(username)) {
      final feed = getByUsername(username);
      feed.insert(0, postWithUid);
    }
    notifyListeners();
    return postWithUid;
  }

  @override
  reply(String body, Post parent) async {
    final child = Post(username: username, body: body, parentUid: parent.uid);
    final reply = await _collection.add(child);
    parent.children.add(reply);
    notifyListeners();
    return reply;
  }

  @override
  getByUsername(String username) => _cache.get(username) ?? [];

  @override
  Future<void> refresh({String? username}) async {
    notifyListeners();
    if (username == null) {
      final posts = await _collection.getAll();
      final tree = _collection.buildCommentTree(posts);
      _home = tree;
    } else {
      final posts = await _collection.getAllByUsername(username);
      final tree = _collection.buildCommentTree(posts);
      _cache.set(username, tree);
    }
    notifyListeners();
  }
}
