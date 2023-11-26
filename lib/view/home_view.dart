import 'package:flutter/material.dart';
import 'package:flutter_webview/view/compose_mail_view.dart';
import 'package:flutter_webview/view/in_app_browser.dart';
import 'package:flutter_webview/view/read_mail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('compose Mail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ComposeMailView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Read Mail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReadMailView()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('In App Browser Mail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InAppBrowserView()),
                );
              },
            ),
          ],
        )));
  }
}
