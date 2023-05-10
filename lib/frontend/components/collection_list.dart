import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/components/collection_list_item.dart';
import 'package:vinyl_social_network/models/album.dart';

class CollectionListView extends StatelessWidget {
  final List<Album> albums;

  const CollectionListView({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: albums.length,
        itemBuilder: (BuildContext context, int index) {
          final album = albums[index];
          return CollectionListItem(album: album);
        });
  }
}
