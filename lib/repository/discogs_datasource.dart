import 'dart:convert' as convert;

import "package:http/http.dart" as http;

class DiscogsDatasource {
  static final DiscogsDatasource _instance =
      DiscogsDatasource._privateConstructor();

  DiscogsDatasource._privateConstructor();

  static DiscogsDatasource get instance => _instance;

  Future<List<Map<String, dynamic>>> fetchCollectionPages() async {
    List<Map<String, dynamic>> pages = [];

    const discogsApiUrl = "api.discogs.com";
    const discogsUsername = "anzurakizz";

    var page = 1;
    while (true) {
      final url = Uri.https(discogsApiUrl,
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
