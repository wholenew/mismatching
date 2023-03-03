import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/chat_screen/controller/chat_controller.dart';
import 'package:tinder_clone/chat_screen/screens/chat_screen.dart';
import 'package:tinder_clone/matchList_screen/controller/matchList_controller.dart';
import 'package:tinder_clone/models/chat_model.dart';
import 'package:tinder_clone/models/match_model.dart';
import 'package:intl/intl.dart';

class MatchingList extends ConsumerWidget {
  MatchingList({super.key});

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(
      () {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = MediaQuery.of(context).size.width * 0.20;
        if (maxScroll - currentScroll <= delta) {}
      },
    );
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(restorationId: 'MatchingList', slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          pinned: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.favorite),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text("mismatching",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          height: 20,
          color: Colors.red,
          child: Text(
            '新しいミスマッチ',
            style: TextStyle(color: Colors.white),
          ),
        )),
        MatchesList(),
        SliverToBoxAdapter(
            child: Container(
          height: 20,
          color: Colors.red,
          child: Text(
            'メッセージ',
            style: TextStyle(color: Colors.white),
          ),
        )),
        MatchMessageList(),
        OnGoingBottomWidget(),
      ])),
    );
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final state = ref.watch(matchesProvider);
      return state.when(
        data: (items) {
          final matchUsers =
              items.where((match) => match.message.isEmpty).toList();
          return matchUsers.isEmpty
              ? SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '新しいミスマッチングはありません',
                        style: TextStyle(color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(matchesProvider.notifier).fetchFirstBatch();
                        },
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              : MatchListBuilder(
                  matches: items,
                );
        },
        error: (e, stack) => SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.info),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'エラー',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
        loading: () => SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onGoingLoading: (items) {
          return MatchListBuilder(matches: items);
        },
        onGoingError: (items, e, stackTrace) {
          return MatchListBuilder(matches: items);
        },
      );
    }));
  }
}

class MatchListBuilder extends ConsumerWidget {
  const MatchListBuilder({Key? key, required this.matches}) : super(key: key);

  final List<Match> matches;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchUsers = matches.where((user) => user.message.isEmpty).toList();
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: ListView.builder(
            padding: EdgeInsets.only(left: 10, top: 10),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: matchUsers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  ref
                      .read(matchProvider.notifier)
                      .update((state) => matchUsers[index]);
                  ref.read(chatsProvider.notifier).fetchFirstBatch();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                  ref.read(chatsProvider.notifier).reset();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 60,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(matchUsers[index].photoUrl),
                      ),
                      Text(matchUsers[index].name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class MatchMessageList extends ConsumerWidget {
  const MatchMessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: ((context, ref, child) {
      final state = ref.watch(matchesProvider);
      return state.when(
        data: (items) {
          final matches = items.where((match) => match.message != '').toList();

          return matches.isEmpty
              ? SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'まだメッセージはありません',
                        style: TextStyle(color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(matchesProvider.notifier).fetchFirstBatch();
                        },
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              : MatchMessageListBuilder(
                  matches: matches,
                );
        },
        error: (e, stack) => SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.info),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'エラー',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
        loading: () => SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onGoingLoading: (items) {
          return MatchMessageListBuilder(matches: items);
        },
        onGoingError: (items, e, stackTrace) {
          return MatchMessageListBuilder(matches: items);
        },
      );
    }));
  }
}

class MatchMessageListBuilder extends ConsumerWidget {
  const MatchMessageListBuilder({Key? key, required this.matches})
      : super(key: key);

  final List<Match> matches;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateFormat outputFormat = DateFormat('M/dd\nH:mm');
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: [
            InkWell(
                onTap: () async {
                  ref
                      .read(matchProvider.notifier)
                      .update((state) => matches[index]);
                  ref.read(chatsProvider.notifier).fetchFirstBatch();
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));

                  ref.read(matchesProvider.notifier).fetchFirstBatch();
                  ref.read(chatsProvider.notifier).reset();
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  margin:
                      EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                  child: ListTile(
                    isThreeLine: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(matches[index].photoUrl),
                    ),
                    title: Text(matches[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis)),
                    subtitle: Text(
                      matches[index].message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                    trailing: Text(
                      outputFormat.format(matches[index].createdAt.toLocal()),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            Divider(
              height: 5,
              color: Colors.grey,
            )
          ],
        );
      },
      childCount: matches.length,
    ));
  }
}

class OnGoingBottomWidget extends ConsumerWidget {
  const OnGoingBottomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Consumer(builder: ((context, ref, child) {
              final state = ref.watch(matchesProvider);
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                onGoingLoading: (items) {
                  return const Center(child: CircularProgressIndicator());
                },
                onGoingError: (items, e, stackTrace) {
                  return Center(
                    child: Column(
                      children: const [
                        Icon(Icons.inbox),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'something whnt wrong!',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  );
                },
              );
            }))));
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchesProvider);

    return SliverToBoxAdapter(
        child: state.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: ((items) {
        final nomoreItems = ref.read(matchesProvider.notifier).noMoreItems;
        return nomoreItems
            ? const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'NoMoreItemsFound!!!!!!!',
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox.shrink();
      }),
    ));
  }
}

class ScrollToTopButton extends ConsumerWidget {
  const ScrollToTopButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (BuildContext context, Widget? child) {
        double scrollOffset = scrollController.offset;
        return scrollOffset > MediaQuery.of(context).size.height * 0.5
            ? FloatingActionButton(
                tooltip: "Scroll to top",
                child: const Icon(Icons.arrow_upward),
                onPressed: () async {
                  scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                })
            : const SizedBox.shrink();
      },
    );
  }
}
