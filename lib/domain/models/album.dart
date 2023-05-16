import 'package:isar/isar.dart';

part 'album.g.dart';

@collection
class Album {
  Id id = Isar.autoIncrement;

  late final String discogsId;
  late final String discogsResourceUrl;
  late final String discogsReleaseUrl;
  late String imageUrl;
  late final String title;
  late final String artistName;
  late final int releaseYear;
  late final int durationSeconds;

  Album(
      {required this.discogsId,
      required this.discogsResourceUrl,
      required this.discogsReleaseUrl,
      required this.imageUrl,
      required this.title,
      required this.artistName,
      required this.releaseYear,
      required this.durationSeconds});

  Map<String, dynamic> toJson() => {
        'discogs_id': discogsId,
        'discogs_resource_url': discogsResourceUrl,
        'discogs_release_url': discogsReleaseUrl,
        'image_url': imageUrl,
        'title': title,
        'artist_name': artistName,
        'release_year': releaseYear,
        'length_in_seconds': durationSeconds,
      };
}
