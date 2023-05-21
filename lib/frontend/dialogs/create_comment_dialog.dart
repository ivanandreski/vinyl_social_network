import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';

class CreateCommentDialog extends StatefulWidget {
  late final int postId;
  late final int? commentId;

  CreateCommentDialog({required this.postId, this.commentId, super.key});

  @override
  State<StatefulWidget> createState() => _CreateCommentDialogState();
}

class _CreateCommentDialogState extends State<CreateCommentDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _handleSubmit() async {
    final body = _textEditingController.text;
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.createComment(
        postId: widget.postId, body: body, commentId: widget.commentId);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Post a comment"),
        content: TextField(
          controller: _textEditingController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Comment',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Submit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ]);
  }
}
