import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red.withOpacity(0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  ));
}
