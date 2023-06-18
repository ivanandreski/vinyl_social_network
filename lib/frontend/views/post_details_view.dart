import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/api/post_service.dart';
import 'package:vinyl_social_network/domain/models/comment.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/frontend/components/like_toggle.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/dialogs/create_comment_dialog.dart';
import 'package:vinyl_social_network/frontend/views/album_details_view.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';
import 'package:vinyl_social_network/frontend/views/user_details_view.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class PostDetailsView extends StatefulWidget {
  static const String route = 'post-details';

  const PostDetailsView({super.key});

  @override
  State<StatefulWidget> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  Widget _buildCommentTree(List<Comment> comments) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return _buildCommentTile(comment);
      },
    );
  }

  Widget _buildCommentTile(Comment comment) {
    return GestureDetector(
        onLongPress: () {
          final postId = ModalRoute.of(context)!.settings.arguments as int;
          showDialog(
              context: context,
              builder: (BuildContext context) => CreateCommentDialog(
                    postId: postId,
                    commentId: comment.id,
                  ));
        },
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, UserDetailsView.route,
                                arguments: comment.user.id);
                          },
                          child: Text(
                            comment.user.fullName,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColor),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Text(
                        dateTimeToDateString(comment.createdAt),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        comment.body,
                        softWrap: true,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8.0),
                if (comment.replies.isNotEmpty)
                  _buildReplyList(comment.replies),
              ],
            ),
          ),
        ));
  }

  Widget _buildReplyList(List<Comment> replies) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: replies.length,
        itemBuilder: (context, index) {
          final reply = replies[index];
          return _buildCommentTile(reply);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as int;
    final postViewModel = context.watch<PostViewModel>();
    final post = postViewModel.getPostByPostId(postId);

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
              const Divider(),
              Text(post.title),
              const Divider(),
              Row(
                children: [
                  Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AlbumDetailsView.route,
                              arguments: post.album.discogsId);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.music_note),
                              Text(post.album.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12)),
                            ]),
                      )),
                ],
              ),
              const Divider(),
              Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CreateCommentDialog(
                                                  postId: post.postId));
                                    },
                                    child: const Text('Comment',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey)))),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 35,
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, UserDetailsView.route,
                                      arguments: post.user.id);
                                },
                                child: Text(post.user.fullName,
                                    style: const TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  )),
              _buildCommentTree(post.comments),
            ],
          ),
        )));
  }
}
