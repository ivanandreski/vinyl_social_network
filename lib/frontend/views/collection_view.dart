import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/bottom_nav_bar.dart';
import 'package:vinyl_social_network/frontend/components/collection_list.dart';
import 'package:vinyl_social_network/frontend/components/setup_discogs.dart';
import 'package:vinyl_social_network/service/account_service.dart';

class CollectionView extends StatelessWidget {
  static const route = "/home";

  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel =
        context.watch<ProfileViewModel>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Collection"),
        ),
        // todo: add grid view, switcher btn and loading
        body: profileViewModel.discogsUsername != null ? const CollectionListView() : const SetupDiscogs(),
        bottomNavigationBar: const BottomNavBar());
  }
}
