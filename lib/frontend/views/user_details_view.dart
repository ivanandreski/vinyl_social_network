import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/domain/enum/user_profile_visibility_enum.dart';
import 'package:vinyl_social_network/domain/models/user.dart';
import 'package:vinyl_social_network/frontend/components/custom_circular_progress_indicator.dart';
import 'package:vinyl_social_network/frontend/components/follow_toggle.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';

class UserDetailsView extends StatefulWidget {
  static const String route = "user-details";

  const UserDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final _userService = UserService.instance;

  User? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userId = ModalRoute.of(context)!.settings.arguments as int;
      await _fetchUser(userId);
      setState(() {
        _loading = false;
      });
    });
  }

  _fetchUser(int userId) async {
    final user = await _userService.getUser(userId);
    _user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Profile")),
        body: SingleChildScrollView(
            // todo: add checks for friends only
            child: (_loading == true || _user == null)
                ? const CustomCircularProgressIndication()
                : (_user!.visibility == UserProfileVisibilityEnum.private
                    ? const Text("This profile is private!")
                    : Center(
                        child: Column(
                          children: [
                            Text(
                              _user!.fullName,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _user!.email,
                              style: const TextStyle(fontSize: 26),
                            ),
                            FollowToggle(
                                userId: _user!.id, isFollow: _user!.isFollow),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: <Widget>[
                                      Text("${_user!.followers}", style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                                      const Text("Followers", style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: <Widget>[
                                      Text("${_user!.following}", style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                      const Text("Following", style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ))));
  }
}
