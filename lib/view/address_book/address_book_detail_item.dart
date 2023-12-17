import 'package:flutter/material.dart';
import 'package:flutter_webview/model/address_book/address_book_detail_item_obj.dart';

class AddressBookDetailItem extends StatefulWidget {
  final AddressBookDetailItemDataObj addressBookDetailDataObj;
  final VoidCallback? onTap;

  const AddressBookDetailItem(
      {super.key, required this.addressBookDetailDataObj, this.onTap});

  @override
  State<AddressBookDetailItem> createState() => _AddressBookDetailItemState();
}

class _AddressBookDetailItemState extends State<AddressBookDetailItem> {
  bool isStared = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Provide the onTap callback
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.addressBookDetailDataObj.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  widget.addressBookDetailDataObj.emailAddress.isNotEmpty
                      ? Text(
                          widget.addressBookDetailDataObj.emailAddress,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox(),
                  widget.addressBookDetailDataObj.title.isNotEmpty
                      ? Text(
                          widget.addressBookDetailDataObj.title,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox(),
                  widget.addressBookDetailDataObj.department.isNotEmpty
                      ? Text(
                          widget.addressBookDetailDataObj.department,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox(),
                  widget.addressBookDetailDataObj.phone.isNotEmpty
                      ? Text(
                          widget.addressBookDetailDataObj.phone,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
