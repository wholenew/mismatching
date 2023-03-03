import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customTextField.dart';

class Profile extends ConsumerWidget {
  Profile({super.key, required this.tabController});
  final TabController tabController;

  final TextEditingController profileController = TextEditingController();

  final formKey = GlobalObjectKey<FormState>('__profile__');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                text: '自己紹介',
                controller: profileController,
                maxLength: 500,
                maxLines: 10,
              ),
              Expanded(child: SizedBox()),
              CustomButton(
                text: '次へ',
                formKey: formKey,
                onTap: () {
                  print(profileController.text);
                  ref
                      .read(userControllerProvider.notifier)
                      .updateUser(profile: profileController.text);
                  primaryFocus?.unfocus();
                  tabController.animateTo(tabController.index + 1);
                },
              )
            ]),
          ),
        ));
  }
}
