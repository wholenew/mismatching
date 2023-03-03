import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final IconData? icon;
  final bool? isObscure;
  CustomNumField({
    Key? key,
    this.controller,
    required this.text,
    this.icon,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
        controller: controller,
        obscureText: isObscure!,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.all(5),
            hintText: text,
            hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
            errorMaxLines: 3,
            errorStyle: TextStyle(
              color: Colors.white,
              overflow: TextOverflow.visible,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.white))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '年齢を入力してください';
          }
          final num = int.parse(value);
          if (20 > num) {
            return '20以上の数字を入力してください';
          }
          if (100 <= num) {
            return '100以下の数字を入力してください';
          }

          return null;
        },
      ),
    );
  }
}
