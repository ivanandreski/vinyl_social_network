import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';

class CreatePostDialog extends StatefulWidget {
  late final Album album;

  CreatePostDialog({required this.album, super.key});

  @override
  State<StatefulWidget> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  bool _showTextField = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return AlertDialog(
      title: Text(_showTextField ? "Create post" : 'Create play session'),
      content: _showTextField
          ? TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Share your thoughts',
              ),
            )
          : const Text('Would you like to share this?'),
      actions: _showTextField
          ? [
              ElevatedButton(
                onPressed: () async {
                  String enteredText = _textEditingController.text;

                  await postViewModel.createPost(
                      enteredText, widget.album.discogsId);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }

                  // maybe navigate to post details screen
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showTextField = false;
                  });
                },
                child: Text('Cancel'),
              ),
            ]
          : [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showTextField = true;
                  });
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
    );
  }
}
