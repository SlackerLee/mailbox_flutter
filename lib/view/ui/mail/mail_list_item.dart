import 'package:flutter/material.dart';
import 'package:flutter_webview/model/mail_list_item_obj.dart';
import 'package:intl/intl.dart';

class MailListItem extends StatefulWidget {
  final MailListItemDataObj mailListItemDataObj;
  final VoidCallback? onTap;

  const MailListItem({super.key, required this.mailListItemDataObj, this.onTap});

  @override
  State<MailListItem> createState() => _MailListItemState();
}

class _MailListItemState extends State<MailListItem> {
  bool isStared = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate = "";
    widget.mailListItemDataObj.sentDate != null
        ? formattedDate = DateFormat('MMM dd, yyyy hh:mm a')
            .format(widget.mailListItemDataObj.sentDate!)
        : formattedDate = "";

    final firstLetter = widget.mailListItemDataObj.avatar.isNotEmpty
        ? ''
        : widget.mailListItemDataObj.sender[0];

    return GestureDetector(
      onTap: widget.onTap, // Provide the onTap callback
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5.0, 5.0, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.mailListItemDataObj.sender,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                  Text(
                    widget.mailListItemDataObj.subject,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.mailListItemDataObj.content,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle the `isStared` property
                            widget.mailListItemDataObj.isStared =
                                !widget.mailListItemDataObj.isStared;
                          });
                          // You can toggle the star state or perform any other action
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            widget.mailListItemDataObj.isStared
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
