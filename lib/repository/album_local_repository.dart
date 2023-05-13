import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/repository/album_local_repository_interface.dart';

// maybe we convert this back to being one service for all models
class AlbumLocalRepository implements AlbumLocalRepositoryInterface {
  AlbumLocalRepository() : super() {
    db = openDB();
  }

  late Future<Isar> db;

  // AlbumLocalRepository() {
  //   db = openDB();
  // }

  @override
  Future<void> saveAlbum(Album newAlbum) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.albums.putSync(newAlbum));
  }

  @override
  Future<void> saveAlbumsBulk(List<Album> newAlbums) async {
    final isar = await db;
    isar.writeTxnSync<List<int>>(() => isar.albums.putAllSync(newAlbums));
  }

  @override
  Future<List<Album>> getAllAlbums() async {
    final isar = await db;
    return await isar.albums.where().findAll();
  }

  // Stream<List<Album>> listenToCourses() async* {
  //   final isar = await db;
  //   yield* isar.albums.where().watch(initialReturn: true);
  // }

  @override
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  @override
  Future<Isar> openDB() async {
    final dir = await getApplicationSupportDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [AlbumSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
