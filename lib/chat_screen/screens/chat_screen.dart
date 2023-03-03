import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/chat_screen/controller/chat_controller.dart';
import 'package:tinder_clone/chat_screen/repository/chat_repository.dart';
import 'package:tinder_clone/matchList_screen/controller/matchList_controller.dart';
import 'package:tinder_clone/models/chat_model.dart';
import 'package:tinder_clone/models/match_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tinder_clone/swipe_screen/controller/swipe_controller.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key});

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatsProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.whenOrNull(data: ((items) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }));
    });
    final controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                restorationId: 'Chat',
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.red,
                    pinned: true,
                    title: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(ref
                                                .read(matchProvider)!
                                                .photoUrl))),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Text(
                                      ref.read(matchProvider)!.name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 40),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(ref.read(matchProvider)!.photoUrl),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(ref.read(matchProvider)!.name),
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
                                          final currentUid =
                                              ref.read(userProvider).uid;
                                          final blockedPerson =
                                              ref.read(matchProvider)?.uid ??
                                                  '';
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

                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.report)),
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
                                          final currentUid =
                                              ref.read(userProvider)?.uid ?? '';
                                          final blockedPersonUid =
                                              ref.read(matchProvider)?.uid ??
                                                  '';
                                          ref
                                              .read(ChatRepositoryProvider)
                                              .block(
                                                  userUid: currentUid,
                                                  swipedUserUid:
                                                      blockedPersonUid,
                                                  matchId: ref
                                                      .read(matchProvider)!
                                                      .matchID);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.person_off)),
                      ],
                    ),
                  ),
                  ChatsList(),
                  SliverToBoxAdapter(
                      child: Container(
                    height: 10,
                  )),
                ],
              ),
            ),
            TextfieldBottom()
          ],
        ),
      ),
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final state = ref.watch(chatsProvider);
      return state.when(
        data: (items) {
          return items.isEmpty
              ? SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'まだメッセージがありません',
                        style: TextStyle(color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(chatsProvider.notifier).fetchFirstBatch();
                        },
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              : ChatsBuilder(
                  chats: items,
                );
        },
        error: (e, stack) => SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.info),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'エラー',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
        loading: () => SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onGoingLoading: (items) {
          return ChatsBuilder(
            chats: items,
          );
        },
        onGoingError: (items, e, stackTrace) {
          return ChatsBuilder(
            chats: items,
          );
        },
      );
    }));
  }
}

class ChatsBuilder extends ConsumerWidget {
  const ChatsBuilder({Key? key, required this.chats}) : super(key: key);

  final List<Chat> chats;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat outputFormat = DateFormat('M/dd\nH:mm');
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Align(
            alignment: ref.read(userProvider).uid != chats[index].senderUID
                ? Alignment.topLeft
                : Alignment.topRight,
            child: ref.read(userProvider).uid != chats[index].senderUID
                ? Container(
                    margin: EdgeInsets.only(top: 20, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    ref.read(matchProvider)!.photoUrl),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                padding: EdgeInsets.all(10),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            2 /
                                            3),
                                child: Text(chats[index].message,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                        ),
                        Text(outputFormat
                            .format(chats[index].createdAt.toLocal()))
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(outputFormat
                            .format(chats[index].createdAt.toLocal())),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 2 / 3),
                          child: Text(chats[index].message,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ));
      },
      childCount: chats.length,
    ));
  }
}

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Consumer(builder: ((context, ref, child) {
              final state = ref.watch(chatsProvider);
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                onGoingLoading: (items) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                onGoingError: (items, e, stackTrace) {
                  return Center(
                    child: Column(
                      children: const [
                        Icon(Icons.inbox),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'エラー',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  );
                },
              );
            }))));
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatsProvider);

    return SliverToBoxAdapter(
        child: state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: ((items) {
        final nomoreItems = ref.read(chatsProvider.notifier).noMoreItems;
        return nomoreItems
            ? const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'NoMoreItemsFound!!!!!!!',
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink();
      }),
    ));
  }
}

class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (BuildContext context, Widget? child) {
        double scrollOffset = scrollController.offset;
        return scrollOffset > MediaQuery.of(context).size.height * 0.5
            ? FloatingActionButton(
                tooltip: "Scroll to top",
                child: const Icon(Icons.arrow_upward),
                onPressed: () async {
                  scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                })
            : const SizedBox.shrink();
      },
    );
  }
}

class TextfieldBottom extends ConsumerWidget {
  TextfieldBottom({super.key});
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: messageController,
                minLines: 1,
                maxLines: 10,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'メッセージを入力してください',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white))),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                onTap: () async {
                  if (messageController.text.isEmpty) return;
                  primaryFocus?.unfocus();
                  await ref
                      .read(chatsProvider.notifier)
                      .sendMessage(messageController.text);
                  messageController.text = '';
                },
                child: Icon(
                  Icons.send_outlined,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
