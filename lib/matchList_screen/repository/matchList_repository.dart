import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/match_model.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';

final matchListRepositoryProvider = Provider((ref) {
  return MatchListRepository(ref);
});

class MatchListRepository {
  final ProviderRef ref;
  MatchListRepository(this.ref);
  Stream<List<Match>> fetchMatches(Match? match) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(ref.watch(userProvider).uid)
          .collection('matches')
          .where('unsubscribe', isEqualTo: 0)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snap) {
        List<Match> matches = [];

        for (var doc in snap.docs) {
          matches.add(Match.fromJson(doc.data()));
        }
        return matches;
      });
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
  }
}
