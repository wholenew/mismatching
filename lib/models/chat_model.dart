import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:tinder_clone/models/dateTime_converter.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String senderUID,
    required String sender,
    required String receiverUID,
    required String receiver,
    required String message,
    required String matchID,
    @DateTimeConverter() required DateTime createdAt,
    required bool isSeen,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
