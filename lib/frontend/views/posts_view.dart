import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/custom_circular_progress_indicator.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/components/post_card.dart';

class PostsView extends StatefulWidget {
  static const title = "Posts";
  static const route = "/posts";

  const PostsView({super.key});

  @override
  State<StatefulWidget> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();

    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text(PostsView.title),
        ),
        body: postViewModel.loading
            ? const CustomCircularProgressIndication()
            : RefreshIndicator(
                onRefresh: () async {
                  postViewModel.getPosts();
                },
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 3, bottom: 3, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(spreadRadius: 1),
                        ],
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                postViewModel.followingOnly == false
                                    ? const Expanded(
                                        flex: 3,
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            "All"),
                                      )
                                    : const Expanded(
                                        flex: 3,
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            "Following only"),
                                      ),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                    value: postViewModel.followingOnly,
                                    onChanged: (bool value) {
                                      postViewModel.setFollowingOnly(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          itemCount: postViewModel.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = postViewModel.posts[index];
                            return Container(
                                padding: const EdgeInsets.all(4),
                                child: PostCard(post: post));
                          }))
                ])));
  }
}
