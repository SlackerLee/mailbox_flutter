import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse('https://www.google.com')),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressIndicator() {
    return LinearProgressIndicator(value: _progress);
  }
}