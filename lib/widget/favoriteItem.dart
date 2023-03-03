import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';

class FavoriteItem extends ConsumerWidget {
  const FavoriteItem({
    Key? key,
    required this.item,
    this.fromSwipe,
  }) : super(key: key);
  final String item;
  final bool? fromSwipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return fromSwipe != null && fromSwipe! == true
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red),
                child: Text(
                  item,
                  style: TextStyle(color: Colors.white),
                )),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                ref.read(userControllerProvider.notifier).addFavoriteItem(item);
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: ref
                                  .watch(userProvider)
                                  .favoriteItems
                                  ?.contains(item) ??
                              false
                          ? Border.all(width: 1, color: Colors.white)
                          : Border.all(
                              width: 1, color: Colors.white.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                  child: Text(
                    item,
                    style:
                        ref.watch(userProvider).favoriteItems?.contains(item) ??
                                false
                            ? TextStyle(color: Colors.white)
                            : TextStyle(color: Colors.white.withOpacity(0.5)),
                  )),
            ),
          );
  }
}
