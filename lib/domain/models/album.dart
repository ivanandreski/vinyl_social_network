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
        'discogsId': discogsId,
        'discogsResourceUrl': discogsResourceUrl,
        'discogsReleaseUrl': discogsReleaseUrl,
        'imageUrl': imageUrl,
        'title': title,
        'artistName': artistName,
        'releaseYear': releaseYear,
        'durationSeconds': durationSeconds,
      };
}
