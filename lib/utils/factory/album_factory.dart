import "package:vinyl_social_network/domain/models/album.dart";

class AlbumFactory {
  static final AlbumFactory _instance = AlbumFactory._privateConstructor();

  AlbumFactory._privateConstructor();

  static AlbumFactory get instance => _instance;

  Album createAlbumFromJson(Map<String, dynamic> albumMap) {
    final artist =
        albumMap['basic_information']['artists'][0]['name'].toString();
    final title = albumMap['basic_information']['title'].toString();
    final discogsId = albumMap['id'].toString();
    final discogsReleaseUrl =
        "https://www.discogs.com/release/${discogsId}-${artist.replaceAll(" ", "-")}-${title.replaceAll(" ", "-")}";

    return Album(
      discogsId: discogsId,
      discogsResourceUrl:
          albumMap['basic_information']['resource_url'].toString(),
      discogsReleaseUrl: discogsReleaseUrl,
      imageUrl: "placeholder",
      title: title,
      artistName: artist,
      releaseYear: albumMap['basic_information']['year'],
      // todo: make logic for extracting total time!
      durationSeconds: 0,
    );
  }
}
