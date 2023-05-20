import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/domain/models/stylus.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:vinyl_social_network/utils/factory/post_factory.dart';
import 'package:vinyl_social_network/utils/factory/stylus_factory.dart';

class PostService {
  static final PostService _instance = PostService._privateConstructor();

  PostService._privateConstructor();

  static PostService get instance => _instance;

  Future<List<Post>> getPosts({String? token}) async {
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
}
