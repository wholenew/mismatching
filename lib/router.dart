import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/EditPhoto_screen/screen/editPhoto_screen.dart';
import 'package:tinder_clone/account_screen/screens/account_screen.dart';
import 'package:tinder_clone/chat_screen/screens/chat_screen.dart';
import 'package:tinder_clone/editProfile_screen/screens/editProfile_screen.dart';
import 'package:tinder_clone/starting_screens/screen/login_screen.dart';
import 'package:tinder_clone/starting_screens/screen/opening_screen.dart';
import 'package:tinder_clone/starting_screens/screen/signup_screen.dart';

import 'package:tinder_clone/swipe_screen/screens/swipe_screen.dart';

import 'matchList_screen/screen/matchingList_screen.dart';

final routeLogOutMap = RouteMap(routes: {
  '/': (_) => MaterialPage(child: Login()),
  '/signup': (_) => MaterialPage(child: Signup())
});

final routeLogInMap = RouteMap(
    onUnknownRoute: (_) => const MaterialPage(child: Opening()),
    routes: {
      '/': (_) => const MaterialPage(child: Opening()),
    });

final routeFinishedProfileMap = RouteMap(
    onUnknownRoute: (_) => MaterialPage(child: SwipeScreen()),
    routes: {
      '/': (_) => MaterialPage(child: SwipeScreen()),
      '/account': (_) => const MaterialPage(child: Account()),
      '/chat': (_) => MaterialPage(child: ChatScreen()),
      '/matchingList': (_) => MaterialPage(child: MatchingList()),
      '/editProfile': (_) => MaterialPage(child: EditProfileScreen()),
      '/editPhoto': (_) => MaterialPage(child: EditPhoto()),
    });
