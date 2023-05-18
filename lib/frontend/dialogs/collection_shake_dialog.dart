import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/frontend/views/album_details_view.dart';

class CollectionShakeDialog extends StatelessWidget {
  const CollectionShakeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final collectionViewModel = context.watch<CollectionViewModel>();
    final album = collectionViewModel.getRandomAlbum();

    return Dialog(
      child: Container(
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(album.imageUrl))),
            ),
            Text(album.title),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AlbumDetailsView.route,
                      arguments: album);
                },
                child: const Text("Details"))
          ],
        ),
      ),
    );
  }
}
