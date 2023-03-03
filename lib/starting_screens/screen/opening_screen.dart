import 'package:flutter/material.dart';

import 'package:tinder_clone/widget/indicator.dart';
import 'package:tinder_clone/starting_screens/screen/age_screen.dart';
import 'package:tinder_clone/starting_screens/screen/favoriteItem_screen.dart';
import 'package:tinder_clone/starting_screens/screen/gender_screen.dart';
import 'package:tinder_clone/starting_screens/screen/name_screen.dart';
import 'package:tinder_clone/starting_screens/screen/photo_screen.dart';
import 'package:tinder_clone/starting_screens/screen/preferredGender_screen.dart';
import 'package:tinder_clone/starting_screens/screen/profile_screen.dart';

class Opening extends StatelessWidget {
  const Opening({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Builder(builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;

          return Scaffold(
            bottomNavigationBar: Indicator(
              tabController: tabController,
            ),
            body:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              Name(
                tabController: tabController,
              ),
              Gender(
                tabController: tabController,
              ),
              Age(
                tabController: tabController,
              ),
              Profile(
                tabController: tabController,
              ),
              Photo(
                tabController: tabController,
              ),
              FavoriteItemScreen(
                tabController: tabController,
              ),
              PreferredGender(
                tabController: tabController,
              ),
            ]),
          );
        }));
  }
}
