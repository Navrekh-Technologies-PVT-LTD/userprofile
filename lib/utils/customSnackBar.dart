import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 3), // Change the duration as needed
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
