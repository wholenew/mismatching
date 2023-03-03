import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String? uid;
  final String? name;

  final List<dynamic>? photoUrlList;
  final List<dynamic>? photoNameList;
  final bool finished;
  final GenderType? myGender;
  final int? age;
  final String? profile;
  final List<dynamic>? favoriteItems;
  final GenderType? preferredGender;
  final List<dynamic>? likeList;
  final List<dynamic>? dislikeList;
  final List<dynamic>? matchList;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? unsubscribe;
  UserModel(
      {this.uid,
      this.name,
      this.photoUrlList,
      this.photoNameList,
      this.finished = false,
      this.myGender,
      this.age,
      this.profile,
      this.favoriteItems,
      this.preferredGender,
      this.likeList,
      this.dislikeList,
      this.matchList,
      this.createdAt,
      this.updatedAt,
      this.unsubscribe});

  UserModel copyWith({
    String? name,
    String? uid,
    List<dynamic>? photoUrlList,
    List<dynamic>? photoNameList,
    bool? finished,
    GenderType? myGender,
    int? age,
    String? profile,
    List<dynamic>? favoriteItems,
    GenderType? preferredGender,
    List<dynamic>? likeList,
    List<dynamic>? dislikeList,
    List<dynamic>? matchList,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? unsubscribe,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      photoUrlList: photoUrlList ?? this.photoUrlList,
      photoNameList: photoNameList ?? this.photoNameList,
      finished: finished ?? this.finished,
      myGender: myGender ?? this.myGender,
      age: age ?? this.age,
      profile: profile ?? this.profile,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      preferredGender: preferredGender ?? this.preferredGender,
      likeList: likeList ?? this.likeList,
      dislikeList: dislikeList ?? this.dislikeList,
      matchList: matchList ?? this.matchList,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      unsubscribe: unsubscribe ?? this.unsubscribe,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'photoUrlList': photoUrlList,
      'photoNameList': photoNameList,
      'finished': finished,
      'myGender': myGender?.displayName,
      'age': age,
      'profile': profile,
      'favoriteItems': favoriteItems,
      'preferredGender': preferredGender?.displayName,
      'likeList': likeList,
      'dislikeList': dislikeList,
      'matchList': matchList,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
      'unsubscribe': unsubscribe,
    };
  }

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      name: snap['name'] ?? '',
      uid: snap.id,
      photoUrlList: snap['photoUrlList'],
      photoNameList: snap['photoNameList'],
      finished: snap['finished'],
      myGender: GenderType.getType(snap['myGender']),
      age: snap['age'],
      profile: snap['profile'],
      favoriteItems: snap['favoriteItems'],
      preferredGender: GenderType.getType(
        snap['preferredGender'],
      ),
      likeList: snap['likeList'],
      dislikeList: snap['dislikeList'],
      matchList: snap['matchList'],
      createdAt: snap['createdAt'].toDate(),
      updatedAt: snap['updatedAt'].toDate(),
      unsubscribe: snap['unsubscribe'],
    );
  }
}

enum GenderType {
  male('男性'),
  female('女性'),
  others('その他'),
  all('全員'),
  ;

  const GenderType(this.displayName);
  final String displayName;

  static GenderType getType(String value) {
    switch (value) {
      case '男性':
        return GenderType.male;
      case '女性':
        return GenderType.female;
      case 'その他':
        return GenderType.others;
      case '全員':
        return GenderType.all;
      default:
        throw Exception('エラー');
    }
  }
}
