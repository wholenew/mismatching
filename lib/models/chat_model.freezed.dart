// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  String get senderUID => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get receiverUID => throw _privateConstructorUsedError;
  String get receiver => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get matchID => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isSeen => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {String senderUID,
      String sender,
      String receiverUID,
      String receiver,
      String message,
      String matchID,
      @DateTimeConverter() DateTime createdAt,
      bool isSeen});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderUID = null,
    Object? sender = null,
    Object? receiverUID = null,
    Object? receiver = null,
    Object? message = null,
    Object? matchID = null,
    Object? createdAt = null,
    Object? isSeen = null,
  }) {
    return _then(_value.copyWith(
      senderUID: null == senderUID
          ? _value.senderUID
          : senderUID // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUID: null == receiverUID
          ? _value.receiverUID
          : receiverUID // ignore: cast_nullable_to_non_nullable
              as String,
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      matchID: null == matchID
          ? _value.matchID
          : matchID // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSeen: null == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$_ChatCopyWith(_$_Chat value, $Res Function(_$_Chat) then) =
      __$$_ChatCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderUID,
      String sender,
      String receiverUID,
      String receiver,
      String message,
      String matchID,
      @DateTimeConverter() DateTime createdAt,
      bool isSeen});
}

/// @nodoc
class __$$_ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res, _$_Chat>
    implements _$$_ChatCopyWith<$Res> {
  __$$_ChatCopyWithImpl(_$_Chat _value, $Res Function(_$_Chat) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderUID = null,
    Object? sender = null,
    Object? receiverUID = null,
    Object? receiver = null,
    Object? message = null,
    Object? matchID = null,
    Object? createdAt = null,
    Object? isSeen = null,
  }) {
    return _then(_$_Chat(
      senderUID: null == senderUID
          ? _value.senderUID
          : senderUID // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      receiverUID: null == receiverUID
          ? _value.receiverUID
          : receiverUID // ignore: cast_nullable_to_non_nullable
              as String,
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      matchID: null == matchID
          ? _value.matchID
          : matchID // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSeen: null == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chat with DiagnosticableTreeMixin implements _Chat {
  const _$_Chat(
      {required this.senderUID,
      required this.sender,
      required this.receiverUID,
      required this.receiver,
      required this.message,
      required this.matchID,
      @DateTimeConverter() required this.createdAt,
      required this.isSeen});

  factory _$_Chat.fromJson(Map<String, dynamic> json) => _$$_ChatFromJson(json);

  @override
  final String senderUID;
  @override
  final String sender;
  @override
  final String receiverUID;
  @override
  final String receiver;
  @override
  final String message;
  @override
  final String matchID;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  final bool isSeen;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chat(senderUID: $senderUID, sender: $sender, receiverUID: $receiverUID, receiver: $receiver, message: $message, matchID: $matchID, createdAt: $createdAt, isSeen: $isSeen)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chat'))
      ..add(DiagnosticsProperty('senderUID', senderUID))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('receiverUID', receiverUID))
      ..add(DiagnosticsProperty('receiver', receiver))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('matchID', matchID))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('isSeen', isSeen));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chat &&
            (identical(other.senderUID, senderUID) ||
                other.senderUID == senderUID) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiverUID, receiverUID) ||
                other.receiverUID == receiverUID) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.matchID, matchID) || other.matchID == matchID) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSeen, isSeen) || other.isSeen == isSeen));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, senderUID, sender, receiverUID,
      receiver, message, matchID, createdAt, isSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatCopyWith<_$_Chat> get copyWith =>
      __$$_ChatCopyWithImpl<_$_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatToJson(
      this,
    );
  }
}

abstract class _Chat implements Chat {
  const factory _Chat(
      {required final String senderUID,
      required final String sender,
      required final String receiverUID,
      required final String receiver,
      required final String message,
      required final String matchID,
      @DateTimeConverter() required final DateTime createdAt,
      required final bool isSeen}) = _$_Chat;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  String get senderUID;
  @override
  String get sender;
  @override
  String get receiverUID;
  @override
  String get receiver;
  @override
  String get message;
  @override
  String get matchID;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  bool get isSeen;
  @override
  @JsonKey(ignore: true)
  _$$_ChatCopyWith<_$_Chat> get copyWith => throw _privateConstructorUsedError;
}
