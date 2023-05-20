import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';

class LikeToggle extends StatefulWidget {
  late final int postId;

  LikeToggle({required this.postId, super.key});

  @override
  State<StatefulWidget> createState() => _LikeToggleState();

  late final Function toggleLike;
}

class _LikeToggleState extends State<LikeToggle> {

  @override
  Widget build(BuildContext context) {
  final postViewModel = context.watch<PostViewModel>();

    return TextButton(
        onPressed: () async {
          await postViewModel.likePost(widget.postId);
          // setState(() {
          //   liked = !liked;
          // });
        },
        child: Container(
          width: 70,
          child: Row(children: [
            postViewModel.getPostByPostId(widget.postId).youLiked == true
                ? Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
            )
                : Icon(
              Icons.favorite_outline,
              size: 24.0,
            ),
            SizedBox(width: 10),
            Text(
              postViewModel.getPostByPostId(widget.postId).likes.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            )
          ]),
        ));
  }
}
