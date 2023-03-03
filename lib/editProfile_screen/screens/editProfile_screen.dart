import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/constants/lists.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customTextField.dart';
import 'package:tinder_clone/widget/favoriteItem.dart';

class EditProfileScreen extends ConsumerWidget {
  EditProfileScreen({
    super.key,
  });

  final TextEditingController profileController = TextEditingController();

  final formKeyProfile = GlobalObjectKey<FormState>('__editProfile__');
  final formKeyItem = GlobalObjectKey<FormState>('__editFavoriteItem__');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    profileController.text = ref.watch(userProvider).profile ?? '自己紹介';
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Form(
                      key: formKeyProfile,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
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
                            Text("自己紹介",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              text: '',
                              controller: profileController,
                              maxLength: 500,
                              maxLines: 10,
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
                            SingleChildScrollView(
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    interestingItems.length,
                                    ((index) {
                                      return FavoriteItem(
                                          item: interestingItems[index]);
                                    }),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              text: '戻る',
                              onTap: () {
                                ref.read(userProvider.notifier).update((state) {
                                  if (profileController.text == '') {
                                    profileController.text = '自己紹介';
                                  }
                                  final newUser = state.copyWith(
                                      profile: profileController.text);

                                  return newUser;
                                });
                                primaryFocus?.unfocus();
                                ref
                                    .read(userControllerProvider.notifier)
                                    .saveUser(context);
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                    ),
                  )))),
    );
  }

  List<Widget> getItems() {
    var listTemp = [
      false,
      false,
      false,
      true,
      true,
      false,
      true,
      false,
      false,
      false,
      true,
      true,
      false,
      true,
      true
    ];
    final List<Widget> faviriteItems = <Widget>[];

    for (var i = 0; i < interestingItems.length; i++) {
      if (i % 3 == 0) {
        faviriteItems.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ));
      }
    }
    return faviriteItems;
  }
}
