import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/frontend/components/collection_list_item.dart';

class CollectionListView extends StatefulWidget {
  const CollectionListView({super.key});

  @override
  State<StatefulWidget> createState() => _CollectionListViewState();
}

class _CollectionListViewState extends State<CollectionListView> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text =
        context.read<CollectionViewModel>().searchParam;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionViewModel collectionViewModel =
        context.watch<CollectionViewModel>();

    // TODO: make dedicated loading widget
    return collectionViewModel.loading
        ? const Text("Loading")
        : Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      top: 3, bottom: 3, left: 20, right: 20),
                  child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                      onChanged: (value) =>
                          collectionViewModel.setSearchParam(value))),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: kBottomNavigationBarHeight),
                      itemCount:
                          collectionViewModel.filteredAlbums().length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final album =
                            collectionViewModel.filteredAlbums()[index];
                        return CollectionListItem(album: album);
                      }))
            ],
          );
  }
}
