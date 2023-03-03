import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/swipe_screen/repository/swipe_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

final SwipeControllerProvider =
    StateNotifierProvider<SwipeController, bool>((ref) {
  final swipeRepository = ref.watch(swipeRepositoryProvider);
  return SwipeController(swipeRepository: swipeRepository, ref: ref);
});

final noUserCardsProvider = StateProvider((ref) => false);

final getUsersProvider = StreamProvider((ref) {
  final swipeController = ref.watch(SwipeControllerProvider.notifier);
  return swipeController.getUsers();
});

final userListProvider = StateProvider<List<UserModel>>((ref) {
  return <UserModel>[];
});

class SwipeController extends StateNotifier<bool> {
  final SwipeRepository _swipeRepository;
  final Ref _ref;
  SwipeController({
    required SwipeRepository swipeRepository,
    required Ref ref,
  })  : _swipeRepository = swipeRepository,
        _ref = ref,
        super(false);

  Stream<List<UserModel>> getUsers() {
    UserModel user = _ref.read(userProvider);
    final userListNotifier = _ref.watch(userListProvider.notifier);
    final noUserCardNotifier = _ref.watch(noUserCardsProvider.notifier);
    final userListStream = _swipeRepository.getUsers(user);
    userListStream.listen((userList) {
      if (userList.isEmpty) {
        noUserCardNotifier.update((state) => true);
      } else {
        noUserCardNotifier.update((state) => false);
      }
      userListNotifier.state = userList;
    });
    return userListStream;
  }

  void swipeUser({required UserModel swipedUser, required bool like}) async {
    like
        ? _ref.read(userProvider.notifier).update((state) {
            if (state.likeList != null) {
              state.likeList!.add(swipedUser.uid);
              return state;
            }
            return state;
          })
        : _ref.read(userProvider.notifier).update((state) {
            if (state.dislikeList != null) {
              state.dislikeList!.add(swipedUser.uid);
              return state;
            }
            return state;
          });
    UserModel user = _ref.watch(userProvider);

    await _swipeRepository.swipeUser(
        user: user, swipedUser: swipedUser, like: like);
  }

  void match({required UserModel swipedUser}) async {
    UserModel user = _ref.read(userProvider);

    await _swipeRepository.match(user: user, swipedUser: swipedUser);
  }

  void report({required message}) async {
    await _ref.read(swipeRepositoryProvider).report(message: message);
  }
}
