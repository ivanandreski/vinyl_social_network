import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/album.dart';

class AlbumDetailsView extends StatelessWidget {
  static const String route = 'album-details';

  const AlbumDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final album = ModalRoute.of(context)!.settings.arguments as Album;

    return Scaffold(
        appBar: AppBar(title: const Text("Album Details")),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(album.imageUrl))),
                ),
                Text(album.title)
              ],
            )));
  }
}
