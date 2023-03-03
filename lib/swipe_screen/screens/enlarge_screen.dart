import 'package:flutter/material.dart';
import 'dart:math' as math;

class EnlargeScreen extends StatelessWidget {
  final String tagName;
  final String photoUrl;
  const EnlargeScreen(
      {required this.tagName, required this.photoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Hero(
              tag: tagName,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.red),
                      image: DecorationImage(
                          fit: BoxFit.contain, image: NetworkImage(photoUrl))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
