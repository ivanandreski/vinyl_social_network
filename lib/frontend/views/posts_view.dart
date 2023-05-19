import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';

class PostsView extends StatelessWidget {
  static const title = "Posts";
  static const route = "/posts";

  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Text("Posts"));
  }
}