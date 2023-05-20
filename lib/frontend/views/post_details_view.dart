import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/frontend/components/like_toggle.dart';

class PostDetailsView extends StatelessWidget {
  static const String route = 'post-details';

  const PostDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.6,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(post.album.imageUrl))),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, PostDetailsView.route);
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.music_note),
                                    Text(post.album.artistName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12)),
                                  ]),
                            )),
                      ],
                    ),
                    Divider(),
                    Text(post.title),
                    Divider(),
                    Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      height: 35,
                                      alignment: Alignment.center,
                                      child: LikeToggle(postId: post.postId)),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 35,
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        // todo: go to user profile
                                      },
                                      child: Text(post.user.fullName,
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
