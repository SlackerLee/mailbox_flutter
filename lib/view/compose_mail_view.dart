import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ComposeMailView extends StatefulWidget {
  const ComposeMailView({super.key});

  @override
  State<ComposeMailView> createState() => _ComposeMailViewState();
}

class _ComposeMailViewState extends State<ComposeMailView> with WidgetsBindingObserver {
  InAppWebViewController? _webViewController;

  final GlobalKey webViewKey = GlobalKey();
  final double _progress = 0;

    InAppWebViewOptions options = InAppWebViewOptions(
      // Setting this off for security. Off by default for SDK versions >= 16.
      allowFileAccessFromFileURLs: false,
      // Off by default, deprecated for SDK versions >= 30.
      allowUniversalAccessFromFileURLs: false,
    );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose Mail'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          progressIndicator(),
          const TextField(
            decoration: InputDecoration(labelText: 'To:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Cc:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Bcc:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          Expanded(
            child: InAppWebView(
              key: GlobalKey(),
              initialFile:  'assets/website/composeEditor.html',
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
              clearCache: true,
            )),
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
