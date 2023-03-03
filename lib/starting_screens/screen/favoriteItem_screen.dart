import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/constants/lists.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/favoriteItem.dart';

class FavoriteItemScreen extends ConsumerWidget {
  const FavoriteItemScreen({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decorator = DotsDecorator(
      activeColor: Colors.white,
      size: Size.square(10.0),
      activeSize: Size.square(16.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        color: Colors.red,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("mismatching",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text("興味のあることを選択してください",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                      interestingItems.length,
                      ((index) {
                        return FavoriteItem(item: interestingItems[index]);
                      }),
                    )),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              text: '次へ',
              onTap: () {
                final items = ref.read(userProvider).favoriteItems ?? [];
                if (items.length > 0) {
                  tabController.animateTo(tabController.index + 1);
                  ref.read(userControllerProvider.notifier).updateUser(
                      favoriteItems: ref.read(userProvider).favoriteItems);
                }
              },
            ),
          ]),
        ));
  }
}
