import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdateDialog extends StatelessWidget {
  VersionUpdateDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text('アプリアップデートのお知らせ'),
        content: Text('最新のアプリをダウンロードしてください。'),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://stackoverflow.com/questions/68098806/perform-in-app-force-update-using-current-and-required-build-numbers'));
              },
              child: const Text(
                "更新",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
