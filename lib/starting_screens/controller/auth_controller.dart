import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/starting_screens/repository/auth_repository.dart';
import 'package:tinder_clone/starting_screens/repository/user_repository.dart';
import 'package:tinder_clone/widget/showSnackBar.dart';
import 'package:firebase_storage/firebase_storage.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider),
        userRepository: ref.watch(userRepositoryProvider),
        ref: ref));

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final stateChangeProvider = Provider((ref) {
  final authState = ref.watch(authStateChangeProvider);

  authState.whenData(
    (data) {
      final user = data as User;
      ref
          .read(authControllerProvider.notifier)
          .getUserData(user.uid)
          .listen((userModel) {
        ref.read(userProvider.notifier).update((state) {
          return userModel;
        });
      });
    },
  );

  return authState;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Ref ref;
  AuthController(
      {required this.authRepository,
      required this.userRepository,
      required this.ref})
      : super(false);

  get authStateChange => authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) {
    return userRepository.getUserData(uid);
  }

  void signUp(BuildContext context, String email, String password) async {
    state = true;

    final user = await authRepository.signUp(email, password);

    user.fold((l) {
      showSnackBar(context, l);
      state = false;
    }, (userModel) {
      ref.read(userProvider.notifier).update((state) => userModel);

      state = false;
    });
  }

  void login(BuildContext context, String email, String password) async {
    state = true;
    final user = await authRepository.login(email, password);

    user.fold((l) {
      showSnackBar(context, l);
      state = false;
    }, (userModelStream) {
      userModelStream.listen(
        (user) {
          ref.read(userProvider.notifier).update((state) => user);
          state = false;
        },
      );
    });
  }
}
