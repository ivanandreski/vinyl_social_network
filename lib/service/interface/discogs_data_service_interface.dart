import 'package:vinyl_social_network/domain/models/album.dart';

abstract class DiscogsDataServiceInterface {
  Future<List<Album>> parseDiscogsPagesToAlbums(
      List<Map<String, dynamic>> pages);
}
