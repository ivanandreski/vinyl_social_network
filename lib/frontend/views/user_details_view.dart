import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/domain/enum/user_profile_visibility_enum.dart';
import 'package:vinyl_social_network/domain/models/user.dart';

class UserDetailsView extends StatefulWidget {
  static const String route = "user-details";

  const UserDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
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
    final user = await UserService.instance.getUser(userId);
    _user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User Profile")),
        body: SingleChildScrollView(
            // todo: add checks for friends only
            child: _loading == true
                ? CircularProgressIndicator()
                : (_user!.visibility == UserProfileVisibilityEnum.private
                    ? Text("This profile is private!")
                    : Container(
                        child: Column(
                          children: [Text(_user!.fullName), Text(_user!.email)],
                        ),
                      ))));
  }
}
