import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/collection_list.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/components/setup_discogs.dart';
import 'package:vinyl_social_network/frontend/dialogs/collection_shake_dialog.dart';

class CollectionView extends StatefulWidget {
  static const title = "Collection";
  static const route = "/collection";

  const CollectionView({super.key});

  @override
  State<StatefulWidget> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        showDialog(context: context, builder: (BuildContext context) => const CollectionShakeDialog());
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel =
    context.watch<ProfileViewModel>();

    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text(CollectionView.title),
        ),
        body: profileViewModel.discogsUsername != null ? const CollectionListView() : const SetupDiscogs());
  }
}
