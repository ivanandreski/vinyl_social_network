import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/models/message.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/domain/models/user.dart';
import 'package:vinyl_social_network/utils/constants/shared_preferences_keys.dart';

class CacheService {
  static final CacheService _instance = CacheService._privateConstructor();

  CacheService._privateConstructor();

  static CacheService get instance => _instance;

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.posts);
    await prefs.remove(SharedPreferencesKeys.chat);
    // await prefs.remove(SharedPreferencesKeys.collection);
  }

  Future<void> cachePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKeys.posts, json.encode(posts));
  }

  Future<List<Post>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedPosts = prefs.get(SharedPreferencesKeys.posts);
    if (cachedPosts == null) {
      return [];
    }

    final decodedPosts = json.decode(cachedPosts as String);
    List<Post> posts = [];
    for (dynamic decodedPost in decodedPosts) {
      posts.add(Post(
          postId: decodedPost['postId'],
          title: decodedPost['title'],
          likes: decodedPost['likes'],
          youLiked: decodedPost['youLiked'],
          postedOn: DateTime.parse(decodedPost['postedOn']),
          comments: [],
          user: User(
            id: decodedPost['user']['id'],
            firstName: decodedPost['user']['firstName'],
            lastName: decodedPost['user']['lastName'],
            email: decodedPost['user']['email'],
            createdAt: DateTime.parse(decodedPost['user']['createdAt']),
            visibility: decodedPost['user']['visibility'],
          ),
          album: Album.fromResponse(decodedPost['album'])));
    }

    return posts;
  }

  Future<void> cacheChat(Map<String, List<Message>> chat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKeys.chat, json.encode(chat));
  }

  Future<Map<String, List<Message>>> getChat() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedChat = prefs.get(SharedPreferencesKeys.chat);
    if (cachedChat == null) {
      return {};
    }

    final decodedChat = json.decode(cachedChat as String);
    Map<String, List<Message>> chat = {};
    for (String key in decodedChat.keys) {
      if (chat[key] == null) {
        chat[key] = [];
      }

      for (final valueMessage in decodedChat[key]) {
        chat[key]!.add(Message(
            id: valueMessage['id'],
            body: valueMessage['body'],
            senderId: valueMessage['senderId'],
            receiverId: valueMessage['receiverId'],
            createdAt: DateTime.parse(valueMessage['createdAt']),
            read: valueMessage['read']));
      }
    }

    return chat;
  }
}
