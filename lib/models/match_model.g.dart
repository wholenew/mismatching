// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Match _$$_MatchFromJson(Map<String, dynamic> json) => _$_Match(
      senderUID: json['senderUID'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      message: json['message'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as Timestamp),
      matchID: json['matchID'] as String,
      unsubscribe: json['unsubscribe'] as int,
    );

Map<String, dynamic> _$$_MatchToJson(_$_Match instance) => <String, dynamic>{
      'senderUID': instance.senderUID,
      'uid': instance.uid,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'message': instance.message,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'matchID': instance.matchID,
      'unsubscribe': instance.unsubscribe,
    };
