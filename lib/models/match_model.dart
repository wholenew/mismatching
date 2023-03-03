import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:tinder_clone/models/dateTime_converter.dart';

part 'match_model.freezed.dart';
part 'match_model.g.dart';

@freezed
class Match with _$Match {
  const factory Match({
    required String senderUID,
    required String uid,
    required String name,
    required String photoUrl,
    required String message,
    @DateTimeConverter() required DateTime createdAt,
    required String matchID,
    required int unsubscribe,
  }) = _Match;

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
}
