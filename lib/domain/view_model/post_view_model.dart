import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/post_service.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/service/account_service.dart';

class PostViewModel extends ChangeNotifier {
  final _postService = PostService.instance;
  final _accountService = AccountService.instance;

  bool _loading = true;
  List<Post> _posts = [];

  List<Post> get posts => followingOnly
      ? _posts.where((p) => p.user.isFollow).toList()
      : _posts;

  bool get loading => _loading;

  bool followingOnly = false;
  setFollowingOnly(bool followingOnly) {
    this.followingOnly = followingOnly;
    notifyListeners();
  }

  PostViewModel() {
    getPosts();
  }

  setPosts(List<Post> value) {
    _posts = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Post getPostByPostId(int postId) {
    return _posts.where((element) => element.postId == postId).first;
  }

  getPosts() async {
    // todo: check for internet connection
    // if not available fech from cache isar and display message that yu can view them but edits and ads ill not be saved
    final token = await _accountService.getToken();

    setPosts(await _postService.getPosts(token: token));
    setLoading(false);
  }

  createPost(String text, String discogsId) async {
    final token = await _accountService.getToken();

    setLoading(true);
    await _postService.createPost(
        token: token!, text: text, discogsId: discogsId);
    await getPosts();
    setLoading(false);
  }

  likePost(int postId) async {
    final token = await _accountService.getToken();
    if (token == null) return;

    await _postService.toggleLikePost(token: token, postId: postId);
    await getPosts();
  }

  createComment(
      {required int postId, required String body, int? commentId}) async {
    final token = await _accountService.getToken();
    if (token == null) return;

    await _postService.createComment(
        postId: postId, body: body, token: token, commentId: commentId);
    await getPosts();
  }
}
