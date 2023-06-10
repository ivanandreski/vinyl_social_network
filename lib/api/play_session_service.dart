import 'dart:convert';

import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:http/http.dart' as http;

class PlaySessionService {
  static final PlaySessionService _instance =
      PlaySessionService._privateConstructor();

  PlaySessionService._privateConstructor();

  static PlaySessionService get instance => _instance;

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

  Future<List<dynamic>> getAlbumPlaySessions(String discogsId) async {
    final url = Uri.parse(
        '${Constants.apiUrl}/api/user-play-session/get-for-album-cache?discogsId=$discogsId');
    final token = await AccountService.instance.getToken();
    if (token == null) {
      return [];
    }
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    return response.statusCode == 200 ? json.decode(response.body)['data'] : [];
  }
}
