import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Proceed"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true), child: Text('Yes')),
        TextButton(
            onPressed: () => Navigator.pop(context, false), child: Text('No')),
      ],
    );
  }
}
