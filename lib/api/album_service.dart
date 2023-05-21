import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';

class AlbumService {
  static final AlbumService _instance = AlbumService._privateConstructor();

  AlbumService._privateConstructor();

  static AlbumService get instance => _instance;

  Future<Album> getAlbumById(String discogsId) async {
    final url = Uri.parse('${Constants.apiUrl}/api/album/$discogsId');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
    });
    return Album.fromResponse(json.decode(response.body));
  }
}
