import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/components/profile_dialog_button.dart';
import 'package:vinyl_social_network/frontend/dialogs/profile_visibility_dialog.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';
import 'package:vinyl_social_network/frontend/views/register_view.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class ProfileView extends StatelessWidget {
  static const route = "/profile";

  const ProfileView({super.key});

  // _handleAuthBtnClick(BuildContext context, String route) {
  //   Navigator.pushReplacementNamed(context, route);
  // }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    CollectionViewModel collectionViewModel =
        context.watch<CollectionViewModel>();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: ListView(
          children: [
            if (profileViewModel.token == null) ...[
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterView.route);
                          },
                          child: const Text(RegisterView.title)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginView.route);
                          },
                          child: const Text(LoginView.title)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 1),
              Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (profileViewModel.discogsUsername != null) ...[
                        Text(
                          "Current discogs username: ${profileViewModel.discogsUsername}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await collectionViewModel.clear();
                              await profileViewModel.clearDiscogs();
                            },
                            child: const Text("Clear discogs username")),
                      ] else ...[
                        const Text(
                            "No discogs username is set, go to the collection page!"),
                      ],
                    ],
                  )),
              const Divider(height: 1),
            ] else ...[
              Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${profileViewModel.user?.firstName} ${profileViewModel.user?.lastName}",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        profileViewModel.user?.email ?? "",
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Member since",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        profileViewModel.user?.createdAt != null
                                            ? dateTimeToDateString(
                                                profileViewModel
                                                    .user!.createdAt)
                                            : "",
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await profileViewModel.doLogout();
                            },
                            child: const Text("Log out")),
                      ])),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 1),
              Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (profileViewModel.discogsUsername != null) ...[
                        Text(
                          "Current discogs username: ${profileViewModel.discogsUsername}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await collectionViewModel.clear();
                              await profileViewModel.clearDiscogs();
                            },
                            child: const Text("Clear discogs username")),
                      ] else ...[
                        const Text(
                            "No discogs username is set, go to the collection page!"),
                      ],
                    ],
                  )),
              const Divider(height: 1),
              ProfileDialogButton(
                  dialogWidget: const ProfileVisibilityDialog(),
                  text:
                      'Profile visibility: ${profileViewModel.user?.visibility}',
                  icon: const Icon(Icons.person)),
              ProfileDialogButton(
                  dialogWidget: const ProfileVisibilityDialog(),
                  text: 'Change User Details',
                  icon: const Icon(Icons.person)),
              ProfileDialogButton(
                  dialogWidget: const ProfileVisibilityDialog(),
                  text: 'Change Password',
                  icon: const Icon(Icons.lock)),
              ProfileDialogButton(
                  dialogWidget: const ProfileVisibilityDialog(),
                  text: 'Change Email',
                  icon: const Icon(Icons.email)),
              ProfileDialogButton(
                  dialogWidget: const ProfileVisibilityDialog(),
                  text: 'Delete My Account',
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ],
        ));
    // body: Column(
    //   // todo: design square sections of each setting
    //   children: [
    //     if (profileViewModel.discogsUsername != null) ...[
    //       Text(
    //           "Current discogs username: ${profileViewModel.discogsUsername}"),
    //       ElevatedButton(
    //           onPressed: () async {
    //             await collectionViewModel.clear();
    //             await profileViewModel.clearDiscogs();
    //             if (context.mounted) {
    //               Navigator.pushReplacementNamed(
    //                   context, CollectionView.route);
    //             }
    //           },
    //           child: Text("Clear discogs username")),
    //     ] else ...[
    //       Text("No discogs username is set, go to the collection page!"),
    //     ],
    //     if (profileViewModel.token != null) ...[
    //       // todo: make api call for getting the profile with token which returns basic info
    //       Text("Current token: ${profileViewModel.token}"),
    //       ElevatedButton(
    //           onPressed: () async {
    //             final response = await profileViewModel
    //                 .syncCollection(collectionViewModel.albums);
    //
    //             if (context.mounted) {
    //               showSnackBar(context, response);
    //             }
    //           },
    //           child: Text("Sync Collection")),
    //       ElevatedButton(
    //           onPressed: () async {
    //             final response = await profileViewModel.doLogout();
    //           },
    //           child: Text("Logout")),
    //     ]
    //   ],
    // )
    // );
  }
}
