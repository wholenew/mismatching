import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/widget/favoriteItem.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/swipe_screen/screens/widget/imageContainer.dart';
import 'package:tinder_clone/swipe_screen/controller/swipe_controller.dart';
import 'package:tinder_clone/swipe_screen/screens/enlarge_screen.dart';

final swipeProvider = StateProvider((ref) => false);
final likeProvider = StateProvider((ref) => false);
final tapButtonProvider = StateProvider((ref) => false);
final endPositionProvider = StateProvider<Offset>((ref) => Offset.zero);
final positionProvider = StateProvider<Offset>((ref) => Offset.zero);
final firstProvider = StateProvider<bool>((ref) => true);
final firstXPositionProvider = StateProvider<double>((ref) => 0);
final ratioProvider = StateProvider<double>((ref) => 0);

class UserCard extends ConsumerWidget {
  final UserModel user;

  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swipeNotifier = ref.read(swipeProvider.notifier);
    final userListState = ref.watch(userListProvider);
    final likeNotifier = ref.read(likeProvider.notifier);
    final likeState = ref.read(likeProvider);
    final swipeState = ref.watch(swipeProvider);
    final endPositionState = ref.read(endPositionProvider);
    final endPositionNotifier = ref.read(endPositionProvider.notifier);
    final tapButtonState = ref.read(tapButtonProvider);
    final tapButtonNotifier = ref.read(tapButtonProvider.notifier);
    final firstXPositionState = ref.watch(firstXPositionProvider);
    final firstXPositionNotifier = ref.watch(firstXPositionProvider.notifier);
    final ratioNotifier = ref.watch(ratioProvider.notifier);
    final firstState = ref.watch(firstProvider);
    final firstNotifier = ref.read(firstProvider.notifier);
    Offset firstPosition = Offset(MediaQuery.of(context).size.width * 0.05,
        MediaQuery.of(context).size.height * 0.05);

    return Positioned(
      top: (() {
        if (swipeState &&
            tapButtonState &&
            user.uid == userListState.last.uid) {
          return firstPosition.dy;
        } else if (swipeState && user.uid == userListState.last.uid) {
          return endPositionState.dy -
              AppBar().preferredSize.height -
              MediaQueryData.fromWindow(window).padding.top;
        } else {
          return firstPosition.dy;
        }
      })(),
      left: swipeState && user.uid == userListState.last.uid && !tapButtonState
          ? endPositionState.dx
          : firstPosition.dx,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: (() {
          if (swipeState && user.uid == userListState.last.uid) {
            final swipeMoveDistance = likeState
                ? -MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width;
            return Matrix4.translationValues(swipeMoveDistance, 0, 0);
          } else {
            return Matrix4.translationValues(0, 0, 0);
          }
        })(),
        onEnd: () {
          if (user.uid == userListState.last.uid) {
            ref
                .read(SwipeControllerProvider.notifier)
                .swipeUser(swipedUser: user, like: likeState);
            ref.read(userListProvider.notifier).update((state) {
              state.removeLast();
              return [...state];
            });

            swipeNotifier.state = false;
            endPositionNotifier.state = Offset(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.05);

            final userUid = ref.read(userProvider).uid;

            if (likeState &&
                user.likeList != null &&
                user.likeList!.contains(userUid)) {
              ref
                  .read(SwipeControllerProvider.notifier)
                  .match(swipedUser: user);
              matchingShowDialog(context: context);
            }
          }
        },
        child: Draggable(
            childWhenDragging: Container(),
            onDragEnd: (details) {
              firstNotifier.state = true;
              ratioNotifier.state = 0;
              tapButtonNotifier.state = false;
              if (details.offset.dx > MediaQuery.of(context).size.width / 3) {
                endPositionNotifier.state = details.offset;
                likeNotifier.state = false;
                swipeNotifier.state = true;
              }
              if (details.offset.dx < -MediaQuery.of(context).size.width / 3) {
                endPositionNotifier.state = details.offset;
                likeNotifier.state = true;
                swipeNotifier.state = true;
              }
            },
            onDragUpdate: (details) {
              if (firstState) {
                firstNotifier.state = false;
                firstXPositionNotifier.state = details.localPosition.dx;
                return;
              }
              double difference =
                  details.localPosition.dx - firstXPositionState;

              difference = difference / (MediaQuery.of(context).size.width / 2);
              if (difference > 0) {
                if (difference > 1) {
                  difference = 1.0;
                }
              } else {
                if (difference < -1) {
                  difference = -1.0;
                }
              }
              ratioNotifier.state = difference;
            },
            child: Stack(children: [
              userStack(isFeedback: false, context: context, ref: ref),
              user.uid == userListState.last.uid ? LikeNopeChild() : Container()
            ]),
            feedback: Stack(children: [
              userStack(isFeedback: true, context: context, ref: ref),
              LikeNopeFeedback(),
            ])),
      ),
    );
  }

  Widget userStack(
      {required bool isFeedback,
      required BuildContext context,
      required WidgetRef ref}) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    final cardHeight = MediaQuery.of(context).size.height * 0.7;
    return Stack(children: [
      ImageContainer(
        url: user.photoUrlList!.first,
        width: cardWidth,
        height: cardHeight,
        fit: BoxFit.cover,
      ),
      Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
                stops: [0.6, 1]),
          )),
      Positioned(
        left: 20,
        bottom: 20,
        width: cardWidth - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(user.name!,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(user.age.toString(),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(
                  width: 10,
                ),
                !isFeedback
                    ? InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.red,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.vertical(
                                    top: Radius.circular(15))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxHeight: 300),
                                          child: Text(user.profile!,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              )),
                                        ),
                                        Text(user.myGender!.displayName,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            )),
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              user.favoriteItems?.length ?? 0,
                                              ((index) {
                                                return FavoriteItem(
                                                  item: user
                                                      .favoriteItems![index],
                                                  fromSwipe: true,
                                                );
                                              }),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          child: Icon(
                            Icons.info,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        child: Icon(
                          Icons.info,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: user.photoUrlList!.length - 1,
                  itemBuilder: (context, index) {
                    final photoName = user.photoNameList![index + 1];
                    final tagName = 'imageHero$photoName';
                    return Hero(
                      tag: tagName,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EnlargeScreen(
                                tagName: tagName,
                                photoUrl: user.photoUrlList![index + 1]);
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: ImageContainer(
                            url: user.photoUrlList![index + 1],
                            height: 100,
                            width: 70,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ]);
  }

  void matchingShowDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.photoUrlList![0]))),
          ),
          Center(
            child: const Text(
              "mismatching!!",
              style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.red,
                  fontSize: 40),
            ),
          ),
        ]),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LikeNopeFeedback extends ConsumerWidget {
  LikeNopeFeedback({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double ratio = ref.watch(ratioProvider);
    if (ratio >= 0) {
      return Positioned(
        top: 20,
        left: 20,
        child: Opacity(
          opacity: ratio,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 252, 18, 2), width: 5)),
            child: Text('好き',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                  color: Color.fromARGB(255, 252, 18, 2),
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),
      );
    } else {
      ratio = -ratio;
      return Positioned(
        top: 20,
        right: 20,
        child: Opacity(
          opacity: ratio,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 136, 238, 140), width: 5)),
            child: Text('嫌い',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                  color: Color.fromARGB(255, 136, 238, 140),
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),
      );
    }
  }
}

class LikeNopeChild extends ConsumerWidget {
  LikeNopeChild({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(tapButtonProvider) &&
        ref.read(swipeProvider) &&
        ref.read(likeProvider)) {
      return Positioned(
        top: 20,
        right: 20,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 136, 238, 140), width: 5)),
          child: Text('嫌い',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
                color: Color.fromARGB(255, 136, 238, 140),
                fontWeight: FontWeight.w800,
              )),
        ),
      );
    } else if (ref.read(tapButtonProvider) &&
        ref.read(swipeProvider) &&
        !ref.read(likeProvider)) {
      return Positioned(
        top: 20,
        left: 20,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromARGB(255, 252, 18, 2), width: 5)),
          child: Text('好き',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
                color: Color.fromARGB(255, 252, 18, 2),
                fontWeight: FontWeight.w800,
              )),
        ),
      );
    }
    return Container();
  }
}
