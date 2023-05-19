import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/models/stylus.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:vinyl_social_network/utils/factory/stylus_factory.dart';

class StylusService {
  static final StylusService _instance = StylusService._privateConstructor();

  StylusService._privateConstructor();

  static StylusService get instance => _instance;

  Future<List<Stylus>> getStyluses({required String token}) async {
    final url =
        Uri.parse('${Constants.apiUrl}/api/user-stylus/get-user-styluses');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    return StylusFactory.instance
        .makeStylusesFromResponse(json.decode(response.body));
  }

  Future<void> createStylus(
      {required String stylusName, required String token}) async {
    final url = Uri.parse('${Constants.apiUrl}/api/user-stylus/create');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"stylus_name": stylusName}));
  }

  Future<void> retireStylus(
      {required int stylusId, required String token}) async {
    final url =
        Uri.parse('${Constants.apiUrl}/api/user-stylus/$stylusId/toggle-retire');
    final response = await http.put(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<void> deleteStylus(
      {required int stylusId, required String token}) async {
    final url =
    Uri.parse('${Constants.apiUrl}/api/user-stylus/$stylusId/delete');
    final response = await http.delete(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
  }
}
