import "package:vinyl_social_network/models/album.dart";

class AlbumFactory {
  static final AlbumFactory _instance = AlbumFactory._privateConstructor();

  AlbumFactory._privateConstructor();

  static AlbumFactory get instance => _instance;

  Album createAlbumFromJson(Map<String, dynamic> albumMap) {
    return Album(
      discogsId: albumMap['id'].toString(),
      discogsResourceUrl:
          albumMap['basic_information']['resource_url'].toString(),
      imageUrl: "PLACEHOLDER",
      title: albumMap['basic_information']['title'].toString(),
      artistName: albumMap['basic_information']['artists'][0]['resource_url']
          .toString(),
      releaseYear: albumMap['basic_information']['year'],
      durationSeconds: 0,
    );
  }
}
