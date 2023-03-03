import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tinder_clone/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final authProvider = Provider((ref) => FirebaseAuth.instance);

class AuthRepository {
  get authStateChange => FirebaseAuth.instance.authStateChanges();

  Future<Either<String, UserModel>> signUp(
      String email, String password) async {
    UserCredential credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //todo
      UserModel user = UserModel(
        uid: credential.user!.uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return Either.right(user);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message!);
    } catch (e) {
      return Either.left(e.toString());
    }
  }

  Future<Either<String, Stream<UserModel>>> login(
      String email, String password) async {
    UserCredential credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //todo
      final user = FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user?.uid)
          .snapshots()
          .map((snap) {
        if (!snap.exists) {
          final user = UserModel(
            uid: credential.user!.uid,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          return user;
        }
        return UserModel.fromSnapshot(snap);
      });

      return Either.right(user);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.toString());
    } catch (e) {
      return Either.left(e.toString());
    }
  }
}
