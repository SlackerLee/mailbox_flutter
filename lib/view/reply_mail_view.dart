import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/model/mail_data_obj.dart';
import 'package:flutter_webview/model/ui/mail_checkbox_item.dart';
import 'package:flutter_webview/utils/alert_util.dart';
import 'package:flutter_webview/view/ui/mail/mail_common_textfield.dart';
import 'package:flutter_webview/view/ui/mail/mail_recipients_textfield.dart';

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
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? mailContent = await webViewController?.evaluateJavascript(
              source: "editor.getContents();");
          if (mailContent != null) {
            showAlertDialog(mailContent); // TODO change to send mail function
          }
        },
        child: const Icon(Icons.send),
      ),
      body: Column(
        children: [
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
                      fillColor: MaterialStateProperty.all(Colors.transparent),
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
            initialValue: mail.from,
            label: 'From: ',
            mainContext: context,
            readOnly: false,
            onChanged: (value) {
              setState(() {
                mail.from = value;
              });
            },
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailRecipientsTextField(
            label: 'To: ',
            mainContext: context,
            readOnly: false,
            initialValue: mail.to,
            onChanged: (value) {
              setState(() {
                mail.to = value;
              });
            },
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailRecipientsTextField(
              label: 'Cc: ',
              mainContext: context,
              initialValue: mail.cc,
              readOnly: false,
              onChanged: (value) {
                setState(() {
                  mail.cc = value;
                });
              }),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailRecipientsTextField(
              label: 'Bcc: ',
              mainContext: context,
              readOnly: false,
              onChanged: (value) {
                setState(() {
                  mail.bcc = value;
                });
              }),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'Subject: ',
            mainContext: context,
            initialValue: mail.subject,
            readOnly: false,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'Data: ',
            mainContext: context,
            initialValue: mail.sentDate.toString(),
            readOnly: false,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          Expanded(
            child: InAppWebView(
              key: webViewKey,
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
                // changing the webview from read only to editable
                // Inject CSS assets
                await webViewController?.injectCSSFileFromAsset(
                    assetFilePath: "assets/website/meStyle.css");
                await webViewController?.injectCSSFileFromAsset(
                    assetFilePath: "assets/website/suneditor.min.css");
                // Inject JS assets
                await webViewController?.injectJavascriptFileFromAsset(
                    assetFilePath: "assets/website/meEditor.js");
                await webViewController?.injectJavascriptFileFromAsset(
                    assetFilePath: "assets/website/suneditor.min.js");
                _initEditor();
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
    initSunEditor();
  """);
  }

  void showAlertDialog(String content) {
    AlertUtil.showConfirmAlertDialog(context, 'Confirmation', content, () {
      // Handle onDismissed callback
      Navigator.pop(context);
    });
  }
}
