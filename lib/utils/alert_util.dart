import 'package:flutter/material.dart';

class AlertUtil {
  static void showConfirmAlertDialog(BuildContext context, String title,
      String message, VoidCallback onDismissed) {
    showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onDismissed();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
