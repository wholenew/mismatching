import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/chat_screen/repository/chat_repository.dart';

import 'package:tinder_clone/matchList_screen/matchingList_state.dart';
import 'package:tinder_clone/models/chat_model.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:tinder_clone/models/match_model.dart';

final matchProvider = StateProvider<Match?>(((ref) => null));

final chatsProvider =
    StateNotifierProvider<ChatController<Chat, Match>, MatchingListState<Chat>>(
        (ref) {
  return ChatController(
    sendMessage: (message) {
      final chat = Chat(
        receiverUID: ref.read(matchProvider)!.uid,
        senderUID: ref.read(userProvider).uid!,
        createdAt: DateTime(2022, 1, 1),
        sender: ref.read(userProvider).name!,
        receiver: ref.read(matchProvider)!.name,
        matchID: ref.read(matchProvider)!.matchID,
        message: message,
        isSeen: false,
      );
      return ref
          .read(ChatRepositoryProvider)
          .sendMessage(chat: chat, user: ref.read(userProvider));
    },
    itemsPerBatch: 0,
    fetchNextItems: (chat) {
      return ref
          .watch(ChatRepositoryProvider)
          .fetchChat(chat, ref.read(matchProvider)!);
    },
  )..init();
});

class ChatController<T, P> extends StateNotifier<MatchingListState<T>> {
  ChatController({
    required this.sendMessage,
    required this.itemsPerBatch,
    required this.fetchNextItems,
  }) : super(const MatchingListState.loading());

  final Future<void> Function(String message) sendMessage;

  final Stream<List<T>> Function(T? item) fetchNextItems;
  final int itemsPerBatch;
  final List<T> _items = [];

  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  void init() {
    if (_items.isEmpty) fetchFirstBatch();
  }

  void reset() {
    state = MatchingListState.data(List<T>.empty());
  }

  bool noMoreItems = false;
  void updateData(Stream<List<T>> result) {
    result.listen((itemList) {
      try {
        if (_items.isEmpty) {
          _items.addAll(itemList);
          (_items as List<Chat>)
              .sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
          state = MatchingListState.data(_items);
        } else {
          (itemList as List<Chat>)
              .sort(((a, b) => a.createdAt.compareTo(b.createdAt)));

          state = MatchingListState.data(itemList);
        }
      } catch (e) {}
    });
  }

  Future<void> fetchFirstBatch() async {
    state = MatchingListState.loading();
    try {
      final Stream<List<T>> result = _items.isEmpty
          ? await fetchNextItems(null)
          : await fetchNextItems(_items.first);

      updateData(result);
    } catch (e, stackTrace) {
      state = MatchingListState.onGoingError(_items, e, stackTrace);
    }
  }

  Future<void> fetchNextBatch() async {
    if (noMoreItems) {
      return;
    }
    if (_timer.isActive) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});
    if (state == MatchingListState<T>.onGoingLoading(_items)) {
      return;
    }
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await fetchNextItems(_items.first);
      updateData(result);
    } catch (e, stackTrace) {
      state = MatchingListState.onGoingError(_items, e, stackTrace);
    }
  }
}
