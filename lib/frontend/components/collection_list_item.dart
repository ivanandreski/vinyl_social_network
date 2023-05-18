import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/frontend/views/album_details_view.dart';

class CollectionListItem extends StatelessWidget {
  final Album album;

  const CollectionListItem({super.key, required this.album});

  // TODO: make this more responsive with percent and flex

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AlbumDetailsView.route,
                arguments: album);
          },
          child: Stack(
            children: [
              Positioned(
                  top: 35,
                  child: Material(
                    child: Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(-10.0, 10.0),
                                blurRadius: 20.0,
                                spreadRadius: 4.0)
                          ]),
                    ),
                  )),
              Positioned(
                  top: 15,
                  left: 8,
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(album.imageUrl))),
                    ),
                  )),
              Positioned(
                  top: 45,
                  left: 170,
                  child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            album.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF363f93),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(album.artistName,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          Divider(color: Colors.black),
                          Text(album.releaseYear.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )))
            ],
          ),
        ));
  }
}
