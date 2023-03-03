import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/repository/user_repository.dart';
import 'package:tinder_clone/widget/showSnackBar.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, bool>((ref) =>
        UserController(
            userRepository: ref.watch(userRepositoryProvider), ref: ref));
final userProvider = StateProvider<UserModel>((ref) => UserModel());

final StateProvider genderCheckboxProvider = StateProvider<GenderType?>((ref) {
  return null;
});

class UserController extends StateNotifier<bool> {
  final UserRepository userRepository;
  final Ref ref;
  UserController({required this.userRepository, required this.ref})
      : super(false);
  void updateUser({
    String? name,
    String? photoUrl,
    bool? finished,
    GenderType? myGender,
    int? age,
    String? profile,
    List<dynamic>? photoUrlList,
    List<dynamic>? favoriteItems,
    GenderType? preferredGender,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    ref.read(userProvider.notifier).update((state) => state.copyWith(
        name: name,
        photoUrlList: photoUrlList,
        finished: finished,
        myGender: myGender,
        age: age,
        profile: profile,
        favoriteItems: favoriteItems,
        preferredGender: preferredGender,
        createdAt: createdAt,
        updatedAt: updatedAt));
  }

  Future<void> uploadUserPhoto(BuildContext context, XFile image) async {
    final res = await userRepository.uploadUserPhoto(image);
    res.fold((l) => showSnackBar(context, l), (urlNameList) {
      ref.read(userProvider.notifier).update((state) {
        final newPhotoUrlList = state.photoUrlList;
        final newPhotoNameList = state.photoNameList;
        if (newPhotoUrlList != null && newPhotoNameList != null) {
          newPhotoUrlList.add(urlNameList[0]);
          newPhotoNameList.add(urlNameList[1]);
          return state.copyWith(
              photoUrlList: newPhotoUrlList, photoNameList: newPhotoNameList);
        } else {
          return state.copyWith(
              photoUrlList: [urlNameList[0]], photoNameList: [urlNameList[1]]);
        }
      });
    });
  }

  Future deleteUserPhoto(int index, String photoName) async {
    await userRepository.deleteUserPhoto(photoName);
    ref.read(userProvider.notifier).update((state) {
      final newPhotoUrlList = state.photoUrlList;
      final newPhotoNameList = state.photoNameList;
      if (newPhotoUrlList != null && newPhotoNameList != null) {
        newPhotoNameList.removeAt(index);
        newPhotoUrlList.removeAt(index);
        return state.copyWith(
            photoUrlList: newPhotoUrlList, photoNameList: newPhotoNameList);
      }
      return state;
    });
  }

  void addFavoriteItem(String favoriteItem) {
    ref.read(userProvider.notifier).update((state) {
      final newfavoriteItems = state.favoriteItems;
      if (newfavoriteItems != null) {
        if (newfavoriteItems.contains(favoriteItem)) {
          newfavoriteItems.remove(favoriteItem);
        } else {
          newfavoriteItems.add(favoriteItem);
        }
        return state.copyWith(favoriteItems: newfavoriteItems);
      } else {
        return state.copyWith(
          favoriteItems: [favoriteItem],
        );
      }
    });
  }

  Future<void> saveUser(BuildContext context) async {
    final userModel = ref.read(userProvider);
    final res = await userRepository.saveUser(userModel);
    userModel.copyWith();
    res.fold((l) => showSnackBar(context, l),
        (user) => ref.read(userProvider.notifier).state = user);
  }
}
