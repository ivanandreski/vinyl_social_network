import 'package:flutter/material.dart';
import 'package:vinyl_social_network/models/album.dart';

class CollectionListItem extends StatelessWidget {
  final Album album;

  const CollectionListItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
            child: Row(children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 35,
                                  child: Text(album.title)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  height: 35, child: Text(album.artistName)))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              height: 35,
                              child: Text(album.releaseYear.toString()))
                        ],
                      ),
                    ],
                  )),
              Expanded(
                flex: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(album.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ])));
  }
}
