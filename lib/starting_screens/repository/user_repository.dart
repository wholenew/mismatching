import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';

final userRepositoryProvider = Provider((ref) {
  return UserRepository();
});

class UserRepository {
  Future<Either<String, List<String>>> uploadUserPhoto(XFile image) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref('${FirebaseAuth.instance.currentUser!.uid}')
          .child(image.name);
      final file = File(image.path);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return right([downloadUrl, image.name]);
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  deleteUserPhoto(String photoName) async {
    Reference ref = FirebaseStorage.instance
        .ref('${FirebaseAuth.instance.currentUser!.uid}/${photoName}');
    await ref.delete();
  }

  Future<Either<String, UserModel>> saveUser(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(e.message ?? 'エラー');
    } catch (e) {
      return left(e.toString());
    }
  }

  Stream<UserModel> getUserData(String uid) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) {
      if (!snap.exists) {
        final user = UserModel(
          uid: uid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          unsubscribe: 0,
        );
        return user;
      }
      return UserModel.fromSnapshot(snap);
    });
    return user;
  }
}
