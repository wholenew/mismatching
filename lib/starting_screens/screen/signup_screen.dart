import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/main.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/termsOfService.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customCheckbox.dart';
import 'package:tinder_clone/widget/customTextField.dart';
import 'package:tinder_clone/widget/versionUpdateDialog.dart';
import 'package:tinder_clone/termsOfService.dart';

final checkTOSProvider = StateProvider<bool>((ref) => false);

class Signup extends ConsumerWidget {
  Signup({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalObjectKey<FormState>('__signup__');
  bool _flag = false;
  bool _check = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return ref.read(versionCheckProvider)
        ? VersionUpdateDialog()
        : SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.8),
                          child: Form(
                            key: formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 100,
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
                                        child: Text("MisMatching",
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
                                    text: 'メールアドレス',
                                    controller: emailController,
                                    icon: Icons.email,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomTextField(
                                    text: 'パスワード   ',
                                    controller: passwordController,
                                    icon: Icons.lock,
                                    isObscure: true,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text("利用規約",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        termsOfService,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                        activeColor: Colors.lightBlue,
                                        value: ref.watch(checkTOSProvider),
                                        onChanged: ((value) {
                                          ref
                                              .read(checkTOSProvider.notifier)
                                              .state = value ?? false;
                                        }),
                                      ),
                                      Text(
                                        '利用規約に同意する',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  ref.watch(checkTOSProvider)
                                      ? CustomButton(
                                          text: '登録',
                                          formKey: formKey,
                                          onTap: () {
                                            primaryFocus?.unfocus();
                                            ref
                                                .read(authControllerProvider
                                                    .notifier)
                                                .signUp(
                                                    context,
                                                    emailController.text,
                                                    passwordController.text);
                                          },
                                        )
                                      : Opacity(
                                          opacity: 0.5,
                                          child: CustomButton(
                                            text: '登録',
                                            formKey: formKey,
                                            onTap: () {},
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("アカウントをお持ちの場合  ",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          Routemaster.of(context).push('/');
                                        },
                                        child: const Text("ログイン画面へ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 150,
                                  ),
                                ]),
                          ),
                        )),
            )),
          );
  }
}
