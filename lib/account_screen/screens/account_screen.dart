import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/EditPhoto_screen/screen/editPhoto_screen.dart';
import 'package:tinder_clone/editProfile_screen/screens/editProfile_screen.dart';
import 'package:tinder_clone/models/match_model.dart';
import 'package:tinder_clone/models/user_model.dart';
import 'package:tinder_clone/widget/customButton.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
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
        body: Stack(children: [
          Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                foregroundPainter: HalfCirclePainter(),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                ref.read(userProvider).photoUrlList!.first),
                          )),
                    ),
                    Text(
                        ref.read(userProvider).name! +
                            ',' +
                            ref.read(userProvider).age!.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              elevation: 30,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                            ),
                            child: Icon(
                              Icons.photo_camera,
                              size: 40.0,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPhoto()),
                              );
                            },
                          ),
                          Text('写真',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              elevation: 30,
                              shape: CircleBorder(),
                              backgroundColor: Colors.white,
                            ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 40.0,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()),
                              );
                            },
                          ),
                          Text('プロフィール',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(child: SizedBox()),
                CustomButton(
                  text: 'ログアウト',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text('本当にログアウトしますか？'),
                              actions: [
                                GestureDetector(
                                    child: Center(
                                      child: Text(
                                        'はい',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      ref
                                          .read(userProvider.notifier)
                                          .update((state) => UserModel());
                                      while (Navigator.of(context).canPop()) {
                                        Navigator.of(context).pop();
                                      }
                                      await FirebaseAuth.instance.signOut();
                                    })
                              ],
                            ));
                  },
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: '退会',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text('本当に退会しますか？\n退会すると全てのデータが削除されます。'),
                              actions: [
                                GestureDetector(
                                    child: Center(
                                      child: Text(
                                        'はい',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      final userData = ref.read(userProvider);
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userData.uid)
                                          .update({'unsubscribe': 1});

                                      if (userData.matchList != null &&
                                          userData.matchList!.isNotEmpty) {
                                        final List<Match> matches = [];
                                        final snapshot = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(userData.uid)
                                            .collection('matches')
                                            .get();

                                        for (var doc in snapshot.docs) {
                                          matches
                                              .add(Match.fromJson(doc.data()));
                                        }

                                        for (var match in matches) {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userData.uid)
                                              .collection('matches')
                                              .doc(match.matchID)
                                              .update({'unsubscribe': 1});
                                        }

                                        for (var match in matches) {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(match.uid)
                                              .collection('matches')
                                              .doc(match.matchID)
                                              .update({'unsubscribe': 1});
                                        }
                                      }

                                      ref
                                          .read(userProvider.notifier)
                                          .update((state) => UserModel());

                                      final user =
                                          FirebaseAuth.instance.currentUser;

                                      while (Navigator.of(context).canPop()) {
                                        Navigator.of(context).pop();
                                      }
                                      await user?.delete();

                                      await FirebaseAuth.instance.signOut();

                                      while (Navigator.of(context).canPop()) {
                                        Navigator.of(context).pop();
                                      }
                                    })
                              ],
                            ));
                  },
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14;
    canvas.drawCircle(Offset(size.width / 2, 0), size.height * 3 / 4, paint);
  }

  @override
  bool shouldRepaint(oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(oldDelegate) => false;
}
