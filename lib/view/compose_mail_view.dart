import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/common/enum.dart';
import 'package:flutter_webview/model/ui/mail_checkbox_item.dart';
import 'package:flutter_webview/utils/alert_util.dart';
import 'package:flutter_webview/view/signer_info_view.dart';
import 'package:flutter_webview/view/ui/mail/mail_recipients_textfield.dart';

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
            Wrap(
              children: checkboxItems.map((checkboxItem) {
                final title = checkboxItem.keys.first;
                final isChecked = checkboxItem.values.first;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      checkboxItem[title] = !isChecked;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        fillColor:
                            MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                            // if (states.contains(MaterialState.selected)) {
                            return const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            );
                          },
                        ),
                        checkColor: Colors.blue,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxItem[title] = value ?? false;
                          });
                        },
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            MailRecipientsTextField(
              label: 'To: ',
              mainContext: context,
              key: const ValueKey('compoose_tf_to'),
              readOnly: false,
              onChanged: (value) {
                setState(() {
                  to = value;
                });
              },
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            MailRecipientsTextField(
              key: const ValueKey('compoose_tf_cc'),
                label: 'Cc: ',
                mainContext: context,
                readOnly: false,
                onChanged: (value) {
                  setState(() {
                    cc = value;
                  });
                }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            MailRecipientsTextField(
                key: const ValueKey('compoose_tf_bcc'),
                label: 'Bcc: ',
                mainContext: context,
                readOnly: false,
                onChanged: (value) {
                  setState(() {
                    bcc = value;
                  });
                }),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            MailRecipientsTextField(
                label: 'Subject: ',
                mainContext: context,
                readOnly: false,
                onChanged: (value) {
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
