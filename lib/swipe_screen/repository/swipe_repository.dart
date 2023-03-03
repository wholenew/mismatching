import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/user_model.dart';

final swipeRepositoryProvider = Provider((ref) {
  return SwipeRepository();
});

class SwipeRepository {
  Stream<List<UserModel>> getUsers(UserModel user) {
    try {
      if (user.preferredGender!.displayName == '全員') {
        return FirebaseFirestore.instance
            .collection('users')
            .where('unsubscribe', isEqualTo: 0)
            .snapshots()
            .map((snap) {
          List<UserModel> users = [];

          for (var doc in snap.docs) {
            users.add(UserModel.fromSnapshot(doc));
          }

          users = users
              .where((stranger) => stranger.uid != user.uid)
              .where((stranger) =>
                  user.dislikeList?.contains(stranger.uid) == null ||
                  !user.dislikeList!.contains(stranger.uid))
              .where((stranger) =>
                  user.likeList?.contains(stranger.uid) == null ||
                  !user.likeList!.contains(stranger.uid))
              .toList();

          return users;
        });
      } else {
        return FirebaseFirestore.instance
            .collection('users')
            .where('myGender', whereIn: [user.preferredGender!.displayName])
            .where('unsubscribe', isEqualTo: 0)
            .snapshots()
            .map((snap) {
              List<UserModel> users = [];

              for (var doc in snap.docs) {
                users.add(UserModel.fromSnapshot(doc));
              }
              users = users
                  .where((stranger) => stranger.uid != user.uid)
                  .where((stranger) =>
                      user.dislikeList?.contains(stranger.uid) == null ||
                      !user.dislikeList!.contains(stranger.uid))
                  .where((stranger) =>
                      user.likeList?.contains(stranger.uid) == null ||
                      !user.likeList!.contains(stranger.uid))
                  .toList();

              return users;
            });
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<void> swipeUser(
      {required UserModel user,
      required UserModel swipedUser,
      required bool like}) async {
    if (like) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'likeList': FieldValue.arrayUnion(
          [swipedUser.uid],
        ),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'dislikeList': FieldValue.arrayUnion([swipedUser.uid]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  Future<void> match({
    required UserModel user,
    required UserModel swipedUser,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'matchList': FieldValue.arrayUnion([swipedUser.uid])
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(swipedUser.uid)
        .update({
      'matchList': FieldValue.arrayUnion([user.uid])
    });

    final match = await FirebaseFirestore.instance
        .collection('users')
        .doc(swipedUser.uid)
        .collection('matches')
        .doc();

    match.set({
      'senderUID': '',
      'uid': user.uid,
      'name': user.name,
      'photoUrl': user.photoUrlList!.first,
      'message': '',
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'matchID': match.id,
      'unsubscribe': 0,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('matches')
        .doc(match.id)
        .set({
      'senderUID': '',
      'uid': swipedUser.uid,
      'name': swipedUser.name,
      'photoUrl': swipedUser.photoUrlList!.first,
      'message': '',
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'matchID': match.id,
      'unsubscribe': 0,
    });
  }

  Future<void> report({
    required String message,
  }) async {
    final report = await FirebaseFirestore.instance.collection('reports');
    report.add(
      {'message': message},
    );
  }
}
