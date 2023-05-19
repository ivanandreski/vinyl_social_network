import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_play_session_dialog.dart';
import 'package:vinyl_social_network/utils/constants/urls.dart';

class AlbumDetailsView extends StatelessWidget {
  static const String route = 'album-details';

  const AlbumDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final album = ModalRoute.of(context)!.settings.arguments as Album;

    return Scaffold(
        appBar: AppBar(title: const Text("Album Details")),
        body: SingleChildScrollView(
            child: SizedBox(
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
                    Text(
                      album.title,
                      style: TextStyle(fontSize: 32),
                    ),
                    Text(
                      album.artistName,
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      album.releaseYear.toString(),
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Discogs press");
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2.0,
                                                color: Colors.black),
                                            image: const DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(Urls
                                                    .discogsButtonIMageUrl))),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: GestureDetector(
                                        onTap: () {
                                          // todo: pass the album
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CreatePlaySessionDialog());
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.black)),
                                          child: Container(
                                            child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Play",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16)),
                                                  Icon(Icons.music_note)
                                                ]),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
