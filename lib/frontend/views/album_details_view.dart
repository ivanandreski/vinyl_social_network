import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/album_service.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_play_session_dialog.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_post_dialog.dart';
import 'package:vinyl_social_network/utils/constants/urls.dart';

class AlbumDetailsView extends StatefulWidget {
  static const String route = 'album-details';

  const AlbumDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumDetailsViewState();
}

class _AlbumDetailsViewState extends State<AlbumDetailsView> {
  Album? _album;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final discogsId = ModalRoute.of(context)!.settings.arguments as String;
      fetchAlbum(discogsId);
    });
  }

  fetchAlbum(String discogsId) async {
    final album = await AlbumService.instance.getAlbumById(discogsId);
    setState(() {
      _album = album;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Album Details")),
        body: _album == null
            ? Text("Loading")
            : SingleChildScrollView(
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
                                  image: NetworkImage(_album!.imageUrl))),
                        ),
                        Text(
                          _album!.title,
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          _album!.artistName,
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          _album!.releaseYear.toString(),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      CreatePlaySessionDialog(
                                                          album: _album!)).then(
                                                  (value) => {
                                                        if (value == true)
                                                          {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CreatePostDialog(
                                                                        album:
                                                                            _album!))
                                                          }
                                                      });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                      width: 2.0,
                                                      color: Colors.black)),
                                              child: Container(
                                                child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("Play",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      Icon(Icons.music_note)
                                                    ]),
                                              ),
                                              // todo: add list view ith previously played times for this album or say you havent played yet if its empty
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
