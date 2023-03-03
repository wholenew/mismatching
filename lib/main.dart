import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder_clone/router.dart';
import 'package:tinder_clone/starting_screens/controller/auth_controller.dart';
import 'package:tinder_clone/starting_screens/controller/user_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tinder_clone/swipe_screen/controller/swipe_controller.dart';
import 'package:version/version.dart';
import 'firebase_options.dart';

enum UserState {
  none,
  auth,
  finished,
  error,
  loading,
}

final versionCheckProvider = StateProvider((ref) => false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    versionCheck(ref);

    final authState = ref.watch(stateChangeProvider);
    final userModel = ref.read(userProvider);

    return authState.when(
        data: (data) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'mismatching',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data == null) {
                return routeLogOutMap;
              }
              if (ref.watch(userProvider).finished) {
                ref.read(getUsersProvider);
                return routeFinishedProfileMap;
              }
              return routeLogInMap;
            }),
            routeInformationParser: RoutemasterParser(),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () => const CircularProgressIndicator(
              color: Colors.white,
            ));
  }

  void versionCheck(WidgetRef ref) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(info.version);

    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 0),
    ));

    await remoteConfig.setDefaults({
      "force_update_app_version": "1.0.0",
    });

    await remoteConfig.fetchAndActivate();
    final version = remoteConfig.getString("force_update_app_version");
    final newVersion = Version.parse(version);

    ref
        .read(versionCheckProvider.notifier)
        .update((state) => currentVersion.compareTo(newVersion).isNegative);
  }
}
