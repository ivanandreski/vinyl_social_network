import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/service/account_service.dart';

class SetupDiscogs extends StatefulWidget {
  const SetupDiscogs({super.key});

  @override
  State<SetupDiscogs> createState() => _SetupDiscogsState();
}

class _SetupDiscogsState extends State<SetupDiscogs> {
  final _discogsDatasource = DiscogsDatasource.instance;
  final _accountService = AccountService.instance;

  String username = "";
  String error = "";

  _handleSubmitClick(ProfileViewModel profileViewModel) async {
    if (username.isNotEmpty) {
      final response = await _discogsDatasource.fetchUserByUsername(username);
      if (response.success) {
        setState(() {
          error = "";
        });
        // todo: maybe add dialog with success and instructions for creating profile and okay button
        await profileViewModel.changeDiscogsUsername(username);
      } else {
        setState(() {
          error = response.message;
        });
      }
    } else {
      setState(() {
        error = "Username cannot be null";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter you discogs username',
          ),
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
        ),
        Text(
          error,
          style: const TextStyle(color: Colors.red),
        ),
        ElevatedButton(
            onPressed: () => _handleSubmitClick(profileViewModel),
            child: Text("Submit")),
      ],
    );
  }
}
