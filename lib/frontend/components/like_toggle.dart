import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

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
          if (await isInternetConnectionAvailable()) {
            if (context.mounted) {
              await postViewModel.likePost(widget.postId);
            }
          } else {
            if (context.mounted) {
              noInternetSnackBar(context);
            }
          }
        },
        child: SizedBox(
          width: 70,
          child: Row(children: [
            postViewModel.getPostByPostId(widget.postId).youLiked == true
                ? const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    size: 24.0,
                  ),
            const SizedBox(width: 10),
            Text(
              postViewModel.getPostByPostId(widget.postId).likes.toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            )
          ]),
        ));
  }
}
