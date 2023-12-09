import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/common/enum.dart';
import 'package:flutter_webview/utils/alert_util.dart';
import 'package:flutter_webview/view/signer_info_view.dart';

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

  ComposeMenuItem? selectedMenuItem;

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
                  source: "editor.getContents();");
              if (mailContent != null) {
                showAlertDialog(
                    mailContent); // TODO change to send mail function
              }
            },
          ),
          PopupMenuButton<ComposeMenuItem>(
            icon: const Icon(Icons.menu),
            onSelected: handleMenuItemSelected,
            itemBuilder: (BuildContext context) =>
                ComposeMenuItem.values.map((item) {
              return PopupMenuItem<ComposeMenuItem>(
                value: item,
                child: Text(ComposeMenuItemStrings[item]!),
              );
            }).toList(),
          ),
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
                gestureRecognizers: Set()
                  ..add(
                    Factory<TapGestureRecognizer>(
                      () => TapGestureRecognizer()
                        ..onTapDown = (_) {
                          // Handle tap down event
                        },
                    ),
                  ),
                key: webViewKey,
                initialFile: 'assets/website/composeEditor.html',
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    clearCache: true,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                  ),
                ),
                onWebViewCreated: (controller) async {
                  controller.addJavaScriptHandler(
                      handlerName: 'onClickUpdateCallback',
                      callback: (args) {
                        // TODO
                        return args;
                      });
                  controller.addJavaScriptHandler(
                      handlerName: 'inputUpdateCallback',
                      callback: (args) {
                        // TODO
                        return args;
                      });
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
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  )),
            ),
          ],
        ));
  }

  void handleMenuItemSelected(ComposeMenuItem selected) {
    setState(() {
      selectedMenuItem = selected;
    });
    switch (selected) {
      case ComposeMenuItem.signerInfo:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignerInfoView()),
        );
        break;
      case ComposeMenuItem.discard:
        Navigator.pop(context);
        break;
      case ComposeMenuItem.save:
        // Handle 'save' selection
        break;
      case ComposeMenuItem.settings:
        // Handle 'settings' selection
        webViewController?.addJavaScriptHandler(
            handlerName: 'handlerFooWithArgs',
            callback: (args) {
              print(args);
              // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
            });

        break;
      default:
        break;
    }
  }
}
