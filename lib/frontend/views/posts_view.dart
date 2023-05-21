import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/post_card.dart';

class PostsView extends StatelessWidget {
  static const title = "Posts";
  static const route = "/posts";

  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: postViewModel.loading
            ? CircularProgressIndicator()
            : ListView.builder(
                padding: const EdgeInsets.only(left: 8, right: 8),
                itemCount: postViewModel.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = postViewModel.posts[index];
                  return Container(
                      padding: const EdgeInsets.all(4),
                      child: PostCard(post: post));
                }));
  }
}
