import 'package:flutter/material.dart';
import 'package:flutter_webview/model/address_book/address_book_detail_item_obj.dart';

class UserInfoView extends StatefulWidget {
  final AddressBookDetailItemDataObj addressBookDetailDataObj;

  const UserInfoView({super.key, required this.addressBookDetailDataObj});

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60.0,
              // TODO
              child: Icon(
                Icons.person,
                size: 80.0,
              ),
            ),
            const SizedBox(height: 8.0),
            widget.addressBookDetailDataObj.name.isNotEmpty
                ? Text(
                    widget.addressBookDetailDataObj.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 8.0),
            widget.addressBookDetailDataObj.title.isNotEmpty
                ? Text(
                    widget.addressBookDetailDataObj.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 8.0),
            widget.addressBookDetailDataObj.emailAddress.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Text(
                            widget.addressBookDetailDataObj.emailAddress,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                    ],
                  )
                : SizedBox(),
            widget.addressBookDetailDataObj.phone.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Text(
                            widget.addressBookDetailDataObj.phone,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
