import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';

class CustomCheckbox extends ConsumerWidget {
  String item;
  bool value;
  GenderType? gender;
  CustomCheckbox({Key? key, this.item = '', this.value = false, this.gender})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 1.0, color: Colors.white),
            ),
            checkColor: Colors.white,
            activeColor: Colors.red,
            value: ref.watch(genderCheckboxProvider) == gender ? true : false,
            onChanged: (value) {
              value ?? false
                  ? ref.read(genderCheckboxProvider.notifier).state = gender
                  : ref.read(genderCheckboxProvider.notifier).state = null;
            }),
        Text(item,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            )),
      ],
    );
  }
}
