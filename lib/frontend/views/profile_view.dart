import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: profileViewModel.token != null
            ? Text(profileViewModel.token!)
            : Column(
                children: [
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
              ),
        bottomNavigationBar: const BottomNavBar());
  }
}
