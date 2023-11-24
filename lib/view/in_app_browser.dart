import 'package:flutter/material.dart';

class InAppBrowserView extends StatefulWidget {
  const InAppBrowserView({super.key});

  @override
  State<InAppBrowserView> createState() => _InAppBrowserViewState();
}

class _InAppBrowserViewState extends State<InAppBrowserView> with WidgetsBindingObserver {
  final double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppWebView Example'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          progressIndicator(),
          const Expanded(
            child: Text("data"),
            ),
  
        ],
      ),
    );
  }

  Widget progressIndicator() {
    return LinearProgressIndicator(value: _progress);
  }
}