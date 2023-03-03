// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      senderUID: json['senderUID'] as String,
      sender: json['sender'] as String,
      receiverUID: json['receiverUID'] as String,
      receiver: json['receiver'] as String,
      message: json['message'] as String,
      matchID: json['matchID'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as Timestamp),
      isSeen: json['isSeen'] as bool,
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'senderUID': instance.senderUID,
      'sender': instance.sender,
      'receiverUID': instance.receiverUID,
      'receiver': instance.receiver,
      'message': instance.message,
      'matchID': instance.matchID,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'isSeen': instance.isSeen,
    };
