import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final IconData? icon;
  final bool isObscure;
  final int maxLength;
  final int maxLines;
  CustomTextField(
      {Key? key,
      this.controller,
      required this.text,
      this.icon,
      this.isObscure = false,
      this.maxLength = 50,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: isObscure,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          counterStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(5),
          hintText: text,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          errorStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.white))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$textを入力してください';
        }

        return null;
      },
    );
  }
}
