import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final GlobalKey<FormState>? formKey;
  final double? width;
  final double height;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.formKey,
      this.width,
      this.height = 50,
      this.textColor = Colors.white,
      this.borderColor = Colors.white,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (formKey == null) {
          return onTap();
        }
        if (formKey!.currentState!.validate()) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: borderColor)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          )),
        ),
      ),
    );
  }
}
