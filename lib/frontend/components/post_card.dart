import 'package:flutter/material.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/frontend/components/custom_network_image.dart';
import 'package:vinyl_social_network/frontend/components/like_toggle.dart';
import 'package:vinyl_social_network/frontend/views/post_details_view.dart';
import 'package:vinyl_social_network/frontend/views/user_details_view.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class PostCard extends StatelessWidget {
  late final Post post;

  PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            onPressed: () async {
              if (await isInternetConnectionAvailable()) {
                if (context.mounted) {
                  Navigator.pushNamed(context, PostDetailsView.route,
                      arguments: post.postId);
                }
              } else {
                if (context.mounted) {
                  noInternetSnackBar(context);
                }
              }
            },
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomNetworkImage(
                    imageUrl: post.album.imageUrl,
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height: 100,
                        alignment: Alignment.topCenter,
                        child: Text(
                          post.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const Divider(),
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
                      onPressed: () async {
                        if (await isInternetConnectionAvailable()) {
                          if (context.mounted) {
                            Navigator.pushNamed(context, PostDetailsView.route,
                                arguments: post.postId);
                          }
                        } else {
                          if (context.mounted) {
                            noInternetSnackBar(context);
                          }
                        }
                      },
                      child: Text('Comments: ${post.numOfComments}',
                          style: TextStyle(fontSize: 12, color: Colors.grey))),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {
                      if (await isInternetConnectionAvailable()) {
                        if (context.mounted) {
                          Navigator.pushNamed(context, UserDetailsView.route,
                              arguments: post.user.id);
                        }
                      } else {
                        if (context.mounted) {
                          noInternetSnackBar(context);
                        }
                      }
                    },
                    child: Text(post.user.fullName,
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
