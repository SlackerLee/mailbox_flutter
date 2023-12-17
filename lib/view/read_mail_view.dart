import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview/model/mail_data_obj.dart';
import 'package:flutter_webview/model/ui/mail_checkbox_item.dart';
import 'package:flutter_webview/view/mail/mail_common_textfield.dart';
import 'package:flutter_webview/view/reply_mail_view.dart';

class ReadMailView extends StatefulWidget {
  const ReadMailView({super.key});

  @override
  State<ReadMailView> createState() => _ReadMailViewState();
}

class _ReadMailViewState extends State<ReadMailView>
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
    // Example mail obj for testing
    final mailDataObj = MailDataObj(
        'user1@mail.com',
        'user22@mail.com',
        'hello@mail.com',
        'tester@mail.com',
        'subject',
        DateTime(2020, 5, 5), """
    <html>
        <head>
          <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        </head>
        <body>
          <p>Hello World!</p>
        </body>
    </html>
    """);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Mail'),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReplyMailView(mailDataObj: mailDataObj),
            ),
          );
        },
        child: const Icon(Icons.turn_left),
      ),
      body: Column(
        children: [
          progressIndicator(),
          Wrap(
            children: checkboxItems.map((checkboxItem) {
              final title = checkboxItem.keys.first;
              final isChecked = checkboxItem.values.first;
              return Row(
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
                    onChanged: (bool? value) {},
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            }).toList(),
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'From: ',
            mainContext: context,
            initialValue: mailDataObj.from,
            readOnly: true,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'To: ',
            mainContext: context,
            initialValue: mailDataObj.to,
            readOnly: true,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'Cc: ',
            mainContext: context,
            initialValue: mailDataObj.cc,
            readOnly: true,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'Subject: ',
            mainContext: context,
            initialValue: mailDataObj.subject,
            readOnly: true,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          MailCommonTextField(
            label: 'Data: ',
            mainContext: context,
            initialValue: mailDataObj.sentDate.toString(),
            readOnly: true,
            onChanged: (String value) {},
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          Expanded(
            child: InAppWebView(
              key: GlobalKey(),
              initialData: InAppWebViewInitialData(data: mailDataObj.content),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                clearCache: true,
              )),
              onWebViewCreated: (controller) async {
                webViewController = controller;
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
}
