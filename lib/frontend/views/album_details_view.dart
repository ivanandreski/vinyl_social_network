import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vinyl_social_network/api/album_service.dart';
import 'package:vinyl_social_network/api/play_session_service.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_play_session_dialog.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_post_dialog.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';
import 'package:vinyl_social_network/utils/constants/urls.dart';

class AlbumDetailsView extends StatefulWidget {
  static const String route = 'album-details';

  const AlbumDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _AlbumDetailsViewState();
}

class _AlbumDetailsViewState extends State<AlbumDetailsView> {
  final _playSessionService = PlaySessionService.instance;

  Album? _album;
  List<dynamic> _playSessions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final discogsId = ModalRoute.of(context)!.settings.arguments as String;
      _fetchAlbum(discogsId);
      _fetchPlaySessions(discogsId);
    });
  }

  _fetchAlbum(String discogsId) async {
    final album = await AlbumService.instance.getAlbumById(discogsId);
    setState(() {
      _album = album;
    });
  }

  _fetchPlaySessions(String discogsId) async {
    final playSessions =
        await _playSessionService.getAlbumPlaySessions(discogsId);
    setState(() {
      _playSessions = playSessions;
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
                          style: const TextStyle(fontSize: 32),
                        ),
                        Text(
                          _album!.artistName,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          _album!.releaseYear.toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                const Divider(),
                                const SizedBox(
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
                                          onTap: () async {
                                            if (!await launchUrl(
                                              Uri.parse(
                                                  _album!.discogsReleaseUrl),
                                              mode: LaunchMode.inAppWebView,
                                            )) {
                                              throw Exception(
                                                  'Could not launch url');
                                            }
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
                                                    image: AssetImage(
                                                        'assets/discogs-logo-icon.png'))),
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
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Center(
                                    child: Card(
                                        color: Colors.white,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(10),
                                            child: Center(
                                                child: _playSessions.isEmpty
                                                    ? const Text(
                                                        "You haven't listened to this album yet!")
                                                    : Text(
                                                        "You have listened to this album ${_playSessions.length} times!")))))
                              ],
                            ))
                      ],
                    ))));
  }
}
