import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/swipe_screen/screens/widget/userCard.dart';

class ImageContainer extends ConsumerWidget {
  ImageContainer(
      {required this.url, this.width, this.height, this.fit, super.key});
  String url;

  double? width;
  double? height;
  BoxFit? fit = BoxFit.cover;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.red),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
          },
        ),
      ),
    );
  }
}
