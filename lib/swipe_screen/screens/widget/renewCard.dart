import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/swipe_screen/controller/swipe_controller.dart';

class LastCard extends ConsumerWidget {
  final String text;

  const LastCard({required this.text, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Offset firstPosition = Offset(MediaQuery.of(context).size.width * 0.05,
        MediaQuery.of(context).size.height * 0.05);
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    final cardHeight = MediaQuery.of(context).size.height * 0.7;
    return Positioned(
      top: firstPosition.dy,
      left: firstPosition.dx,
      child: Container(
          width: cardWidth,
          height: cardHeight,
          child: Center(
            child: CustomButton(
              text: text,
              width: 200,
              onTap: () => ref.refresh(getUsersProvider),
              backgroundColor: Colors.red,
              borderColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
