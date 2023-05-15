import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/bottom_nav_bar.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';
import 'package:vinyl_social_network/frontend/views/register_view.dart';

class ProfileView extends StatelessWidget {
  static const route = "/profile";

  const ProfileView({super.key});

  // _handleAuthBtnClick(BuildContext context, String route) {
  //   Navigator.pushReplacementNamed(context, route);
  // }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int currentIndex = arguments['currentIndex'] as int;

    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    CollectionViewModel collectionViewModel = context.watch<CollectionViewModel>();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Column(
          // todo: design square sections ofr each setting
          children: [
            if (profileViewModel.discogsUsername != null) ...[
              Text(
                  "Current discogs username: ${profileViewModel.discogsUsername}"),
              ElevatedButton(
                  onPressed: () {
                    // todo: clear discogsUSername from data, navigate to collection view
                  },
                  child: Text("Clear discogs username")),
            ] else ...[
              Text("No discogs username is set, go to the collection page!"),
            ],
            if (profileViewModel.token != null) ...[
              // todo: make api call for getting the profile with token which returns basic info
              Text("Current token: ${profileViewModel.token}"),
              ElevatedButton(
                  onPressed: () async {
                    final response = await profileViewModel.syncCollection(collectionViewModel.albums);
                  },
                  child: Text("Sync Collection")),
            ] else ...[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginView.route);
                  },
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterView.route);
                  },
                  child: Text("Register"))
            ],
          ],
        ),
        bottomNavigationBar: BottomNavBar(currentIndex));
  }
}
