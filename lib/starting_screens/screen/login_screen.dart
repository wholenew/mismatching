import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/main.dart';
import 'package:tinder_clone/router.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/widget/customTextField.dart';
import 'package:tinder_clone/widget/versionUpdateDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends ConsumerWidget {
  Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalObjectKey<FormState>('__login__');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return ref.read(versionCheckProvider)
        ? VersionUpdateDialog()
        : SafeArea(
            child: Scaffold(
                body: Container(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      text: 'パスワード',
                                      controller: passwordController,
                                      icon: Icons.lock,
                                      isObscure: true,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    CustomButton(
                                      text: 'ログイン',
                                      formKey: formKey,
                                      onTap: () {
                                        primaryFocus?.unfocus();
                                        ref
                                            .read(
                                                authControllerProvider.notifier)
                                            .login(
                                                context,
                                                emailController.text,
                                                passwordController.text);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("アカウントをお持ちでない場合  ",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            Routemaster.of(context)
                                                .push('/signup');
                                          },
                                          child: const Text("アカウント作成",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              )),
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ))),
          );
  }
}
