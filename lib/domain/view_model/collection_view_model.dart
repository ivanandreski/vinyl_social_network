import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/repository/album_local_repository.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/service/discogs_data_service.dart';

class CollectionViewModel extends ChangeNotifier {
  final _albumLocalRepository = AlbumLocalRepository.instance;
  final _discogsDatasource = DiscogsDatasource.instance;
  final _discogsDataService = DiscogsDataService.instance;

  bool _loading = false;
  List<Album> _albums = [];

  bool get loading => _loading;
  List<Album> get albums => _albums;

  CollectionViewModel() {
    getAlbums();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setAlbums(List<Album> albums) {
    _albums = albums;
    notifyListeners();
  }

  getAlbums() async {
    List<Album> parsedAlbums = await _albumLocalRepository.getAllAlbums();
    if (parsedAlbums.isEmpty) {
      final pages = await _discogsDatasource.fetchCollectionPages();

      final parsedAlbums =
          await _discogsDataService.parseDiscogsPagesToAlbums(pages);

      await _albumLocalRepository.saveAlbumsBulk(parsedAlbums);
    }

    setAlbums(parsedAlbums);
  }
}
