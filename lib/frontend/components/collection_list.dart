import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/frontend/components/collection_list_item.dart';

class CollectionListView extends StatelessWidget {
  const CollectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionViewModel collectionViewModel =
        context.watch<CollectionViewModel>();
    return collectionViewModel.loading ? Text("Loading") : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: collectionViewModel.albums.length,
        itemBuilder: (BuildContext context, int index) {
          final album = collectionViewModel.albums[index];
          return CollectionListItem(album: album);
        });
  }
}
