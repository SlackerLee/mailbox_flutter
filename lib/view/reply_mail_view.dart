import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/model/mail_data_obj.dart';

class ReplyMailView extends StatefulWidget {
  final MailDataObj mailDataObj;

  const ReplyMailView({super.key, required this.mailDataObj});

  @override
  State<ReplyMailView> createState() => _ReplyMailViewState();
}

class _ReplyMailViewState extends State<ReplyMailView>
    with WidgetsBindingObserver {
  InAppWebViewController? webViewController;

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
    MailDataObj mail = widget.mailDataObj;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reply Mail'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          progressIndicator(),
          TextFormField(
            initialValue: mail.from,
            readOnly: true,
            decoration: InputDecoration(labelText: 'From:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue: mail.to,
            readOnly: true,
            decoration: InputDecoration(labelText: 'To:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue: mail.cc,
            readOnly: true,
            decoration: InputDecoration(labelText: 'Cc:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            initialValue: mail.sentDate.toString(),
            readOnly: true,
            decoration: InputDecoration(labelText: 'Data:'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          Expanded(
            child: InAppWebView(
              key: GlobalKey(),
              initialData: InAppWebViewInitialData(data: mail.content),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  clearCache: true,
                ),
              ),
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },
              onLoadStop: (controller, url) async {
                webViewController = controller;
                // Inject CSS assets
                await webViewController?.injectCSSFileFromAsset(
                    assetFilePath: "assets/website/meStyle.css");
                // Inject JS assets
                await webViewController?.injectJavascriptFileFromAsset(
                    assetFilePath: "assets/website/meEditor.js");

                _initEditor();

                await webViewController?.evaluateJavascript(
                    source: "document.documentElement.outerHTML;");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget progressIndicator() {
    return LinearProgressIndicator(value: _progress);
  }

  void _initEditor() async {
    _injectDivJavascript(divId: "myEditableDiv", contentEditable: true);
    _injectDivJavascript(divId: "meContainer");
  }

  void _injectDivJavascript({String? divId, bool? contentEditable}) async {
    await webViewController?.evaluateJavascript(source: """
    var body = document.body;
    var div = document.createElement('div');
    ${contentEditable != null ? "div.contentEditable = ${contentEditable};" : ""}
    ${divId != null ? "div.id = '${divId}';" : ""}
    div.innerHTML = body.innerHTML;
    body.innerHTML = div.outerHTML;
  """);
  }
}
