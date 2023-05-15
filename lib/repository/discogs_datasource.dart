import 'dart:convert' as convert;
import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:vinyl_social_network/domain/response/discogs_fetch_user_response.dart';
import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';

class DiscogsDatasource {
  static final DiscogsDatasource _instance =
      DiscogsDatasource._privateConstructor();

  DiscogsDatasource._privateConstructor();

  static DiscogsDatasource get instance => _instance;

  final _accountService = AccountService.instance;

  Future<DiscogsFetchUserResponse> fetchUserByUsername(String username) async {
    final url = Uri.https(Constants.discogsApiUrl, "/users/$username");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return DiscogsFetchUserResponse(message: "Success", success: true);
    } else {
      return DiscogsFetchUserResponse(message: json.decode(response.body)['message'], success: false);
    }
  }

  Future<List<Map<String, dynamic>>> fetchCollectionPages() async {
    List<Map<String, dynamic>> pages = [];

    String discogsUsername = (await _accountService.getDiscogsUsername()) ?? "";

    var page = 1;
    while (true) {
      final url = Uri.https(Constants.discogsApiUrl,
          "/users/${discogsUsername}/collection/folders/0/releases", {
        "sort_order": "asc",
        "sort": "artist",
        "per_page": "100",
        "page": page.toString()
      });

      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        pages.add(jsonResponse);
      } else {
        return pages;
      }

      page++;
    }
  }
}
