import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vinyl_social_network/domain/models/album.dart';

class AlbumLocalRepository {
  static final AlbumLocalRepository _instance =
      AlbumLocalRepository._privateConstructor();

  AlbumLocalRepository._privateConstructor() {
    db = openDB();
  }

  static AlbumLocalRepository get instance => _instance;

  late Future<Isar> db;

  Future<void> saveAlbum(Album newAlbum) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.albums.putSync(newAlbum));
  }

  Future<void> saveAlbumsBulk(List<Album> newAlbums) async {
    final isar = await db;
    await isar.writeTxn<List<int>>(() => isar.albums.putAll(newAlbums));
  }

  Future<List<Album>> getAllAlbums() async {
    final isar = await db;
    return await isar.albums.where().findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

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
