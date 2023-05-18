import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, response) {
  final snackBar = SnackBar(
    // todo: make response class with messages from backend or connection issues
    content: Text(response == true ? "Success" : "Something went wrong!"),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  String snakeCaseToSentenceCase(String value) {
    return "${value[0].toUpperCase()}${value.substring(1)}"
        .replaceAll(RegExp(r'(_|-)+'), ' ');
}
