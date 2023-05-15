import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/frontend/components/bottom_nav_bar.dart';
import 'package:vinyl_social_network/frontend/components/collection_list.dart';

class CollectionView extends StatelessWidget {
  static const route = "/home";

  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionViewModel collectionViewModel =
        context.watch<CollectionViewModel>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Collection"),
        ),
        // todo: add grid view, switcher btn and loading
        body: const CollectionListView(),
        bottomNavigationBar: const BottomNavBar());
  }
}
