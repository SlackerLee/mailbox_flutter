import 'package:flutter/material.dart';
import 'package:flutter_webview/view/address_book/address_book_list_view.dart';
import 'package:flutter_webview/view/mail/mail_common_textfield.dart';

class MailRecipientsTextField extends MailCommonTextField {
  const MailRecipientsTextField({
    Key? key,
    required BuildContext mainContext,
    required String label,
    required bool readOnly,
    required ValueChanged<String> onChanged,
    String? initialValue,
  }) : super(
          key: key,
          mainContext: mainContext,
          label: label,
          readOnly: readOnly,
          onChanged: onChanged,
          initialValue: initialValue,
        );

  @override
  Widget titleTextLabel(String label) {
    return GestureDetector(
      onTap: () {
        // Handle onTap event

        Navigator.push(
          mainContext,
          MaterialPageRoute(
            builder: (context) => AddressBookListView(textFieldkey: key),
          ),
        );

      },
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
