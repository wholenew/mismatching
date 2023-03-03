import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customNumField.dart';

class Age extends ConsumerWidget {
  Age({super.key, required this.tabController});
  final TabController tabController;

  final TextEditingController ageController = TextEditingController();
  final formKey = GlobalObjectKey<FormState>('__age__');

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
            child: Column(children: [
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
              Text("あなたの年齢は",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  )),
              const SizedBox(
                height: 30,
              ),
              CustomNumField(
                text: '年齢',
                controller: ageController,
              ),
              const Expanded(child: SizedBox()),
              CustomButton(
                text: '次へ',
                formKey: formKey,
                onTap: () {
                  primaryFocus?.unfocus();
                  tabController.animateTo(tabController.index + 1);
                  ref
                      .read(userControllerProvider.notifier)
                      .updateUser(age: int.parse(ageController.text));
                },
              ),
            ]),
          ),
        ));
  }
}
