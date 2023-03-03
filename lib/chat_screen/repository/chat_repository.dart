import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/models/match_model.dart';
import 'package:tinder_clone/models/user_model.dart';

import '../../models/chat_model.dart';

final ChatRepositoryProvider = Provider((ref) {
  return ChatRepository(ref);
});

class ChatRepository {
  final ProviderRef ref;
  ChatRepository(this.ref);
  Stream<List<Chat>> fetchChat(Chat? chat, Match match) {
    List<Chat> chats = [];
    try {
      return FirebaseFirestore.instance
          .collection('chats')
          .where('matchID', whereIn: [match.matchID])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snap) {
            List<Chat> newChats = [];

            for (var doc in snap.docs) {
              newChats.add(Chat.fromJson(doc.data()));
            }

            return newChats;
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

  Future<void> sendMessage(
      {required Chat chat, required UserModel user}) async {
    await FirebaseFirestore.instance.collection('chats').doc().set({
      'senderUID': chat.senderUID,
      'sender': chat.sender,
      'receiverUID': chat.receiverUID,
      'receiver': chat.receiver,
      'isSeen': chat.isSeen,
      'message': chat.message,
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'matchID': chat.matchID
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('matches')
        .doc(chat.matchID)
        .update({
      'senderUID': user.uid,
      'message': chat.message,
      'createdAt': Timestamp.fromDate(DateTime.now()),
    });
    final id = user.uid == chat.receiver ? chat.senderUID : chat.receiverUID;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('matches')
        .doc(chat.matchID)
        .update({
      'senderUID': user.uid,
      'message': chat.message,
      'createdAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> block({
    required String userUid,
    required String swipedUserUid,
    required String matchId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('matches')
        .doc(matchId)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(swipedUserUid)
        .collection('matches')
        .doc(matchId)
        .delete();
  }
}
