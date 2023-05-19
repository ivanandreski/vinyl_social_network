import 'package:flutter/material.dart';

class CreatePlaySessionDialog extends StatefulWidget {
  // late final Album album; todo: add this to constructor

  const CreatePlaySessionDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePlaySessionDialogState();
}

class _CreatePlaySessionDialogState extends State<CreatePlaySessionDialog> {
  bool _showTextField = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_showTextField ? "Create post" : 'Create play session'),
      content: _showTextField
          ? TextField(
        controller: _textEditingController,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: 'Share your thoghts',
        ),
      )
          : const Text('Would you like to share this?'),
      actions: _showTextField
          ? [
        ElevatedButton(
          onPressed: () {
            String enteredText = _textEditingController.text;

            // todo: send api request to PostController/create

            Navigator.of(context).pop();

            // maybe navigate to post details screen
          },
          child: Text('Submit'),
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
