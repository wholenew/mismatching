import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customCheckbox.dart';

class Gender extends ConsumerWidget {
  Gender({super.key, required this.tabController});
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
        alignment: Alignment.center,
        color: Colors.red,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(child: SizedBox()),
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
            Text("あなたの性別は",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(
              height: 30,
            ),
            CustomCheckbox(
              item: '男性',
              gender: GenderType.male,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCheckbox(
              item: '女性',
              gender: GenderType.female,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCheckbox(
              item: 'その他',
              gender: GenderType.others,
            ),
            Expanded(child: SizedBox()),
            CustomButton(
              text: '次へ',
              onTap: () {
                final mygender = ref.read(genderCheckboxProvider);
                if (mygender != null) {
                  ref
                      .read(userControllerProvider.notifier)
                      .updateUser(myGender: mygender);
                  ref.read(genderCheckboxProvider.notifier).state = null;
                  tabController.animateTo(tabController.index + 1);
                }
              },
            )
          ]),
        ));
  }
}
