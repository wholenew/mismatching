import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tinder_clone/matchList_screen/matchingList_state.dart';
import 'package:tinder_clone/matchList_screen/repository/matchList_repository.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/swipe_screen/repository/swipe_repository.dart';
import 'package:tinder_clone/models/match_model.dart';

final matchesProvider =
    StateNotifierProvider<MatchListController<Match>, MatchingListState<Match>>(
        (ref) {
  return MatchListController(
    itemsPerBatch: 20,
    fetchNextItems: (
      match,
    ) {
      return ref.read(matchListRepositoryProvider).fetchMatches(match);
    },
  )..init();
});

class MatchListController<T> extends StateNotifier<MatchingListState<T>> {
  MatchListController(
      {required this.itemsPerBatch, required this.fetchNextItems})
      : super(const MatchingListState.loading());

  final Stream<List<T>> Function(T? item) fetchNextItems;
  final int itemsPerBatch;
  final List<T> _items = [];

  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  void init() {
    if (_items.isEmpty) fetchFirstBatch();
  }

  bool noMoreItems = false;
  void updateData(List<T> result) {
    noMoreItems = result.length < itemsPerBatch;

    state = MatchingListState.data(result);
  }

  Future<void> fetchFirstBatch() async {
    state = MatchingListState.loading();
    try {
      final Stream<List<T>> result = await fetchNextItems(null);

      result.listen(
        (event) {
          state = MatchingListState.data(event);
        },
      );
    } catch (e, stackTrace) {
      state = MatchingListState.onGoingError(_items, e, stackTrace);
    }
  }
}
