import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/main.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/widget/customTextField.dart';
import 'package:tinder_clone/widget/favoriteItem.dart';
import 'package:tinder_clone/swipe_screen/screens/widget/renewCard.dart';
import 'package:tinder_clone/swipe_screen/screens/widget/userCard.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/swipe_screen/controller/swipe_controller.dart';
import 'package:tinder_clone/widget/versionUpdateDialog.dart';
import 'package:tinder_clone/config.dart' as config;

class SwipeScreen extends ConsumerWidget {
  SwipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getUsersProvider);
    });
    final controller = TextEditingController();

    final currentUser = ref.read(userProvider);
    print(currentUser.name);

    UserModel userData = UserModel();
    final userList = ref.read(userListProvider);
    if (userList.isNotEmpty) {
      userData = userList.last;
    }

    return ref.read(versionCheckProvider)
        ? VersionUpdateDialog()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                actions: [
                  if (ref.read(userListProvider).isNotEmpty)
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                title: Text(
                                  "mismatching",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Column(
                                  children: [
                                    Text(
                                      "このユーザーを報告しますか？",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        hintText: '報告内容を入力してください',
                                      ),
                                      minLines: 1,
                                      maxLines: 10,
                                      maxLength: 1000,
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "送信",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (ref
                                          .read(userListProvider)
                                          .isNotEmpty) {
                                        final currentUid =
                                            currentUser.uid ?? '';
                                        final blockedPerson =
                                            userData.uid ?? '';
                                        final message = controller.text ?? '';
                                        ref
                                            .read(SwipeControllerProvider
                                                .notifier)
                                            .report(
                                          message: '''
                                                  sender:$currentUid,
                                                  blockedPerson:$blockedPerson,

                                                  message:$message
                                                  ''',
                                        );
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.report)),
                  if (ref.read(userListProvider).isNotEmpty)
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.red,
                                title: Text(
                                  "mismatching",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  "このユーザーをブロックしますか？",
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "ブロック",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (ref
                                          .read(userListProvider)
                                          .isNotEmpty) {
                                        ref
                                            .read(tapButtonProvider.notifier)
                                            .state = true;
                                        ref.read(likeProvider.notifier).state =
                                            false;
                                        ref.read(swipeProvider.notifier).state =
                                            true;
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.person_off)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.red,
                              title: Text(
                                "mismatching",
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Text(
                                "絶対に会いたくない人とミスマッチングしてお互いにダメだしし合って自分を磨こう！\n※このアプリでは好みの相手とマッチングしません。\n※このアプリは異性と出会うためのマッチングアプリではありません。",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.help_outline)),
                  IconButton(
                      onPressed: () {
                        Routemaster.of(context).push('/matchingList');
                      },
                      icon: Icon(Icons.chat_outlined)),
                  IconButton(
                      onPressed: () {
                        Routemaster.of(context).push('/account');
                      },
                      icon: Icon(Icons.person)),
                ],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.red],
                        stops: [0, 0.7])),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    bottomButton(ref),
                    ref.watch(noUserCardsProvider) == true
                        ? LastCard(
                            text: 'カードがありません。',
                          )
                        : LastCard(
                            text: '更新',
                          ),
                    ...ref.watch(userListProvider).map((user) {
                      final userCard = UserCard(
                        user: user,
                      );

                      return userCard;
                    }).toList()
                  ],
                ),
              ),
            ),
          );
  }

  Widget bottomButton(WidgetRef ref) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  elevation: 30,
                  shape: CircleBorder(),
                  backgroundColor: Colors.white,
                ),
                child: Icon(
                  Icons.close,
                  size: 40.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (ref.read(userListProvider).isEmpty) return;
                  ref.read(tapButtonProvider.notifier).state = true;
                  ref.read(likeProvider.notifier).state = true;
                  ref.read(swipeProvider.notifier).state = true;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  elevation: 30,
                  shape: CircleBorder(),
                  backgroundColor: Colors.white,
                ),
                child: Icon(
                  Icons.circle_outlined,
                  size: 40.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (ref.read(userListProvider).isEmpty) return;
                  ref.read(tapButtonProvider.notifier).state = true;
                  ref.read(likeProvider.notifier).state = false;
                  ref.read(swipeProvider.notifier).state = true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
