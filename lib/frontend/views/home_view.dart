import 'package:flutter/material.dart';
import 'package:vinyl_social_network/app_config.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/frontend/components/collection_list.dart';

class HomeView extends StatefulWidget {
  static const route = "/home";

  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Album> albums = [];
  bool _checkConfiguration() => true;
  String testImageUrl = "";

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () async {
        List<Album> parsedAlbums =
            await AppConfig.of(context)!.albumLocalRepository.getAllAlbums();
        if (parsedAlbums.isEmpty) {
          final pages = await AppConfig.of(context)!
              .discogsDatasource
              .fetchCollectionPages();

          final parsedAlbums = await AppConfig.of(context)!
              .discogsDataService
              .parseDiscogsPagesToAlbums(pages);

          await AppConfig.of(context)!
              .albumLocalRepository
              .saveAlbumsBulk(parsedAlbums);
        }

        setState(() {
          albums = parsedAlbums;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: CollectionListView(albums: albums));
  }
}
