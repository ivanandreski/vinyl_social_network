import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

String dateTimeToDateString(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString()}-${date.year.toString().padLeft(2, '0')}";
}

String dateTimeToDateTimeString(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString()}-${date.year.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

Future<bool> isInternetConnectionAvailable() async {
  try {
    final url = Uri.parse('http://www.google.com');
    final response = await http.get(url);

    return response.statusCode == 200;
  } on Exception {
    return false;
  }
}


