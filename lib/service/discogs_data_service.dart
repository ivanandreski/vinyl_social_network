import 'package:chaleno/chaleno.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/service/interface/discogs_data_service_interface.dart';
import 'package:vinyl_social_network/utils/factory/album_factory.dart';

class DiscogsDataService implements DiscogsDataServiceInterface {
  const DiscogsDataService() : super();

  @override
  Future<List<Album>> parseDiscogsPagesToAlbums(
      List<Map<String, dynamic>> pages) async {
    List<Album> albums = [];

    for (Map<String, dynamic> page in pages) {
      for (Map<String, dynamic> release in page['releases']) {
        final album = AlbumFactory.instance.createAlbumFromJson(release);
        final response = await Chaleno().load(album.discogsReleaseUrl);
        album.imageUrl = response
                ?.querySelector(".image_3rzgk.bezel_2NSgk > picture > img")
                .src ??
            "No Image Available";

        albums.add(album);
      }
    }

    return albums;
  }
}
