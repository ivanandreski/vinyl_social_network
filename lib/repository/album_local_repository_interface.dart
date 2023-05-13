import 'package:isar/isar.dart';
import 'package:vinyl_social_network/domain/models/album.dart';

abstract class AlbumLocalRepositoryInterface {
  Future<void> saveAlbum(Album newAlbum);

  Future<void> saveAlbumsBulk(List<Album> newAlbums);

  Future<List<Album>> getAllAlbums();

  // Stream<List<Album>> listenToCourses() async* {
  //   final isar = await db;
  //   yield* isar.albums.where().watch(initialReturn: true);
  // }

  Future<void> cleanDb();

  Future<Isar> openDB();
}
