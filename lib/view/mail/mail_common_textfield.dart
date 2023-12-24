import 'package:flutter/material.dart';

class MailCommonTextField extends StatelessWidget {
  final String label;
  final BuildContext mainContext;
  final String? initialValue;
  final String? type;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const MailCommonTextField(
      {super.key,
      required this.mainContext,
      required this.label,
      this.type,
      this.initialValue,
      required this.readOnly,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Row(
          children: <Widget>[
            if (type != null)
              type == "C"
                  ? titleTextLabel(label + ' Confidential: ')
                  : titleTextLabel(label)
            else
              titleTextLabel(label),
            Flexible(
              child: TextFormField(
                  initialValue: initialValue,
                  readOnly: readOnly,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      fontSize: 16,
                      color: type != null
                          ? type == "C"
                              ? Colors.red
                              : Colors.black
                          : null),
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

  Widget titleTextLabel(String label) {
    return FittedBox(
      fit: BoxFit.fill,
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            color: type != null
                ? type == "C"
                    ? Colors.red
                    : Colors.black
                : null),
      ),
    );
  }
}
