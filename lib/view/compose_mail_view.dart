import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/utils/alert_util.dart';

class ComposeMailView extends StatefulWidget {
  const ComposeMailView({super.key});

  @override
  State<ComposeMailView> createState() => _ComposeMailViewState();
}

class _ComposeMailViewState extends State<ComposeMailView>
    with WidgetsBindingObserver {
  InAppWebViewController? webViewController;

  final GlobalKey webViewKey = GlobalKey();
  final double _progress = 0;

  String to = "";
  String from = "";
  String cc = "";
  String bcc = "";
  String subject = "";

  String _menuSelectedValue = "";

  InAppWebViewOptions options = InAppWebViewOptions(
    // Setting this off for security. Off by default for SDK versions >= 16.
    allowFileAccessFromFileURLs: false,
    // Off by default, deprecated for SDK versions >= 30.
    allowUniversalAccessFromFileURLs: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text('Compose Mail'),
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.attachment),
            onPressed: () {
              // TODO: add attachment
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              // TODO: send mail
              String? mailContent = await webViewController?.evaluateJavascript(
                  source: "document.body.outerHTML;");
              if (mailContent != null) {
                showAlertDialog(
                    mailContent); // TODO change to send mail function
              }
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (String value) {
              setState(() {
                // todo
                _menuSelectedValue = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: '1',
                child: Text('Discard'),
              ),
              const PopupMenuItem(
                value: '2',
                child: Text('Setting'),
              ),
              const PopupMenuItem(
                value: '3',
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            progressIndicator(),
            addInputTextField('To: ', (value) {
              setState(() {
                to = value;
              });
            }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            addInputTextField('Cc:  ', (value) {
              setState(() {
                cc = value;
              });
            }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            addInputTextField('Bcc:  ', (value) {
              setState(() {
                bcc = value;
              });
            }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            addInputTextField('Subject: ', (value) {
              setState(() {
                subject = value;
              });
            }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: InAppWebView(
                key: webViewKey,
                initialFile: 'assets/website/composeEditor.html',
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return LinearProgressIndicator(value: _progress);
  }

  void showAlertDialog(String content) {
    AlertUtil.showConfirmAlertDialog(context, 'Confirmation', content, () {
      // Handle onDismissed callback
      Navigator.pop(context);
    });
  }

  Widget addInputTextField(String label, Function(String) onChanged) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Row(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fill,
              alignment: Alignment.center,
              child: Text(label, textAlign: TextAlign.left),
            ),
            Flexible(
              child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: onChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  )),
            ),
          ],
        ));
  }
}
