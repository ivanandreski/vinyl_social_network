import 'dart:convert';

import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:http/http.dart' as http;

class PlaySessionService {
  static final PlaySessionService _instance =
      PlaySessionService._privateConstructor();

  PlaySessionService._privateConstructor();

  static PlaySessionService get instance => _instance;

  // Future<void> createPost(
  //     {required String text,
  //       required String discogsId,
  //       required String token}) async {

  createPlaySession(
      {required int stylusId,
      required String token,
      required String discogsId}) async {
    final url = Uri.parse('${Constants.apiUrl}/api/user-play-session/create');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"stylus_id": stylusId, "discogs_id": discogsId}));
  }
}
