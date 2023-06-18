import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/models/comment.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:vinyl_social_network/utils/factory/post_factory.dart';

class PostService {
  static final PostService _instance = PostService._privateConstructor();

  PostService._privateConstructor();

  static PostService get instance => _instance;

  Future<List<Post>> getPosts() async {
    final token = await AccountService.instance.getToken();
    if (token == null) [];

    final url = Uri.parse('${Constants.apiUrl}/api/post?page=1');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    });
    return PostFactory.instance
        .makePostsFromResponse(json.decode(response.body)['data']);
  }

  Future<void> createPost(
      {required String text,
      required String discogsId,
      required String token}) async {
    final url = Uri.parse('${Constants.apiUrl}/api/post/create');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"text": text, "discogs_id": discogsId}));
  }

  Future<void> toggleLikePost(
      {required String token, required int postId}) async {
    final url = Uri.parse('${Constants.apiUrl}/api/post/$postId/like');
    final response = await http.post(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
  }

  Future<List<Comment>> getPostComments(int postId) async {
    final url = Uri.parse('${Constants.apiUrl}/api/post/$postId/comment');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Comment.fromJsonList(jsonData['comments']);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> createComment(
      {required int postId,
      required String body,
      required String token,
      int? commentId}) async {
    final url = Uri.parse('${Constants.apiUrl}/api/post/$postId/comment/add');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode(
            {"body": body, if (commentId != null) "comment_id": commentId}));
    // return Comment.fromJson(json.decode(response.body));
  }
}
