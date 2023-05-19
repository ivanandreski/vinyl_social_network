import 'package:vinyl_social_network/domain/models/stylus.dart';

class StylusFactory {
  static final StylusFactory _instance = StylusFactory._privateConstructor();

  StylusFactory._privateConstructor();

  static StylusFactory get instance => _instance;

  List<Stylus> makeStylusesFromResponse(List<dynamic> response) {
    return response.map((r) => Stylus(stylusId: r['id'], name: r['stylus_name'], isRetired: r["is_retired"], playtime: r["play_time"])).toList();
  }

}