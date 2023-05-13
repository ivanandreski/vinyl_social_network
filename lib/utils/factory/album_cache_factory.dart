import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/utils/factory/album_factory.dart';

class AlbumCacheFactory {
  static final AlbumCacheFactory _instance =
      AlbumCacheFactory._privateConstructor();

  AlbumCacheFactory._privateConstructor();

  static AlbumCacheFactory get instance => _instance;

  List<Album> fillAlbumCache(List<Map<String, dynamic>> pages) {
    List<Album> albums = [];

    for (Map<String, dynamic> page in pages) {
      for (Map<String, dynamic> release in page['releases']) {
        albums.add(AlbumFactory.instance.createAlbumFromJson(release));
      }
    }

    return albums;
  }
}
