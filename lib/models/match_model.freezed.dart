// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Match _$MatchFromJson(Map<String, dynamic> json) {
  return _Match.fromJson(json);
}

/// @nodoc
mixin _$Match {
  String get senderUID => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get matchID => throw _privateConstructorUsedError;
  int get unsubscribe => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchCopyWith<Match> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchCopyWith<$Res> {
  factory $MatchCopyWith(Match value, $Res Function(Match) then) =
      _$MatchCopyWithImpl<$Res, Match>;
  @useResult
  $Res call(
      {String senderUID,
      String uid,
      String name,
      String photoUrl,
      String message,
      @DateTimeConverter() DateTime createdAt,
      String matchID,
      int unsubscribe});
}

/// @nodoc
class _$MatchCopyWithImpl<$Res, $Val extends Match>
    implements $MatchCopyWith<$Res> {
  _$MatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderUID = null,
    Object? uid = null,
    Object? name = null,
    Object? photoUrl = null,
    Object? message = null,
    Object? createdAt = null,
    Object? matchID = null,
    Object? unsubscribe = null,
  }) {
    return _then(_value.copyWith(
      senderUID: null == senderUID
          ? _value.senderUID
          : senderUID // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchID: null == matchID
          ? _value.matchID
          : matchID // ignore: cast_nullable_to_non_nullable
              as String,
      unsubscribe: null == unsubscribe
          ? _value.unsubscribe
          : unsubscribe // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchCopyWith<$Res> implements $MatchCopyWith<$Res> {
  factory _$$_MatchCopyWith(_$_Match value, $Res Function(_$_Match) then) =
      __$$_MatchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderUID,
      String uid,
      String name,
      String photoUrl,
      String message,
      @DateTimeConverter() DateTime createdAt,
      String matchID,
      int unsubscribe});
}

/// @nodoc
class __$$_MatchCopyWithImpl<$Res> extends _$MatchCopyWithImpl<$Res, _$_Match>
    implements _$$_MatchCopyWith<$Res> {
  __$$_MatchCopyWithImpl(_$_Match _value, $Res Function(_$_Match) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderUID = null,
    Object? uid = null,
    Object? name = null,
    Object? photoUrl = null,
    Object? message = null,
    Object? createdAt = null,
    Object? matchID = null,
    Object? unsubscribe = null,
  }) {
    return _then(_$_Match(
      senderUID: null == senderUID
          ? _value.senderUID
          : senderUID // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchID: null == matchID
          ? _value.matchID
          : matchID // ignore: cast_nullable_to_non_nullable
              as String,
      unsubscribe: null == unsubscribe
          ? _value.unsubscribe
          : unsubscribe // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Match with DiagnosticableTreeMixin implements _Match {
  const _$_Match(
      {required this.senderUID,
      required this.uid,
      required this.name,
      required this.photoUrl,
      required this.message,
      @DateTimeConverter() required this.createdAt,
      required this.matchID,
      required this.unsubscribe});

  factory _$_Match.fromJson(Map<String, dynamic> json) =>
      _$$_MatchFromJson(json);

  @override
  final String senderUID;
  @override
  final String uid;
  @override
  final String name;
  @override
  final String photoUrl;
  @override
  final String message;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  final String matchID;
  @override
  final int unsubscribe;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Match(senderUID: $senderUID, uid: $uid, name: $name, photoUrl: $photoUrl, message: $message, createdAt: $createdAt, matchID: $matchID, unsubscribe: $unsubscribe)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Match'))
      ..add(DiagnosticsProperty('senderUID', senderUID))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('photoUrl', photoUrl))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('matchID', matchID))
      ..add(DiagnosticsProperty('unsubscribe', unsubscribe));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Match &&
            (identical(other.senderUID, senderUID) ||
                other.senderUID == senderUID) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.matchID, matchID) || other.matchID == matchID) &&
            (identical(other.unsubscribe, unsubscribe) ||
                other.unsubscribe == unsubscribe));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, senderUID, uid, name, photoUrl,
      message, createdAt, matchID, unsubscribe);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchCopyWith<_$_Match> get copyWith =>
      __$$_MatchCopyWithImpl<_$_Match>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchToJson(
      this,
    );
  }
}

abstract class _Match implements Match {
  const factory _Match(
      {required final String senderUID,
      required final String uid,
      required final String name,
      required final String photoUrl,
      required final String message,
      @DateTimeConverter() required final DateTime createdAt,
      required final String matchID,
      required final int unsubscribe}) = _$_Match;

  factory _Match.fromJson(Map<String, dynamic> json) = _$_Match.fromJson;

  @override
  String get senderUID;
  @override
  String get uid;
  @override
  String get name;
  @override
  String get photoUrl;
  @override
  String get message;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  String get matchID;
  @override
  int get unsubscribe;
  @override
  @JsonKey(ignore: true)
  _$$_MatchCopyWith<_$_Match> get copyWith =>
      throw _privateConstructorUsedError;
}
