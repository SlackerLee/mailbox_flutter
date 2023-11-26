import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/model/mail_data_obj.dart';

class ReadMailView extends StatefulWidget {
  const ReadMailView({super.key});

  @override
  State<ReadMailView> createState() => _ReadMailViewState();
}

class _ReadMailViewState extends State<ReadMailView>
    with WidgetsBindingObserver {
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
    // Example mail obj for testing
    final mailDataObj = MailDataObj(
        'user1@mail.com',
        'user22@mail.com',
        'hello@mail.com',
        """
    <html>
        <head>
          <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        </head>
        <body>
          <p>Hello World!<p>
        </body>
    </html>
    """,
        DateTime(1560, 5, 5));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Mail'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          progressIndicator(),
          TextFormField(
            initialValue: mailDataObj.from,
            readOnly: true,
            decoration: InputDecoration(labelText: 'From:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue: mailDataObj.to,
            readOnly: true,
            decoration: InputDecoration(labelText: 'To:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue:  mailDataObj.cc,
            readOnly: true,
            decoration: InputDecoration(labelText: 'Cc:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue:  mailDataObj.senetDate.toString(),
            readOnly: true,
            decoration: InputDecoration(labelText: 'Data:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          Expanded(
            child: InAppWebView(
              key: GlobalKey(),
              initialData: InAppWebViewInitialData(data:  mailDataObj.content),
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
