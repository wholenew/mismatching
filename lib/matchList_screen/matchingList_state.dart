import 'package:freezed_annotation/freezed_annotation.dart';

part 'matchingList_state.freezed.dart';

@freezed
abstract class MatchingListState<T> with _$MatchingListState<T> {
  const factory MatchingListState.data(List<T> items) = _Data;
  const factory MatchingListState.loading() = _Loading;
  const factory MatchingListState.error(Object? e, [StackTrace? stackTrace]) =
      _Error;
  const factory MatchingListState.onGoingLoading(List<T> items) =
      _OnGoingLoading;
  const factory MatchingListState.onGoingError(List<T> items, Object? e,
      [StackTrace? stackTrace]) = _OnGoingError;
}
