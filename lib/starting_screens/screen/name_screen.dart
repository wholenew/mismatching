import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customTextField.dart';

class Name extends ConsumerWidget {
  Name({super.key, required this.tabController});
  final TabController tabController;

  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalObjectKey<FormState>('__name__');

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
              CustomTextField(
                text: '名前',
                controller: nameController,
                icon: Icons.account_circle_outlined,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("アプリ上でこのように表示されます\n今後変更できません",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      )),
                ],
              ),
              Expanded(child: SizedBox()),
              CustomButton(
                text: '次へ',
                formKey: formKey,
                onTap: () {
                  ref
                      .read(userControllerProvider.notifier)
                      .updateUser(name: nameController.text);
                  primaryFocus?.unfocus();
                  tabController.animateTo(tabController.index + 1);
                },
              )
            ]),
          ),
        ));
  }
}
