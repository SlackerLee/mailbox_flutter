import 'package:flutter/material.dart';
import 'package:flutter_webview/model/address_book/address_book_detail_item_obj.dart';
import 'package:flutter_webview/view/address_book/address_book_detail_item.dart';

class AddressBookDetailListView extends StatefulWidget {
  final String addressBookName;

  const AddressBookDetailListView({super.key, required this.addressBookName});

  @override
  State<AddressBookDetailListView> createState() =>
      _AddressBookDetailListViewState();
}

class _AddressBookDetailListViewState extends State<AddressBookDetailListView> {
  final List<AddressBookDetailItemDataObj> items = [
    AddressBookDetailItemDataObj(
        "Group A/OGCIO", "grounpA@ogcio.gov", "", "", "OGCIO"),
    AddressBookDetailItemDataObj(
        "Group B/OGCIO", "grounpB@ogcio.gov", "", "", "OGCIO"),
    AddressBookDetailItemDataObj(
        "Group C/OGCIO", "grounpC@ogcio.gov", "", "", "OGCIO"),
    AddressBookDetailItemDataObj("User A/OGCIO", "userA@ogcio.gov",
        "Senior System Manager", "3847 XXXX", "OGCIO"),
    AddressBookDetailItemDataObj("User B/OGCIO", "userB@ogcio.gov",
        "Systems Manager", "3847 XXXX", "OGCIO"),
    AddressBookDetailItemDataObj("User C/OGCIO", "userC@ogcio.gov",
        "Assistant System Manager", "3847 XXXX", "OGCIO"),
    AddressBookDetailItemDataObj("User D/OGCIO", "userDA@ogcio.gov",
        "Analyst Programmer", "3847 XXXX", "OGCIO")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addressBookName),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                // Handle onTap event for the item
                print('Tapped item: ${items[index]}');
              },
              child: Column(
                children: <Widget>[
                  AddressBookDetailItem(addressBookDetailDataObj: items[index]),
                  const Divider(
                    color: Colors.grey,
                    height: 0.0,
                    thickness: 0.3,
                  ),
                ],
              ));
        },
      ),
      //  body: ListView.separated(
      //     itemCount: items.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         key: Key('item_$index'),
      //         title: Text(items[index]),
      //       );
      //     },
      //     separatorBuilder: (context, index) {
      //       return const Divider(
      //         color: Colors.grey,
      //         height: 0.0,
      //         thickness: 1.0,
      //       );
      //     },
      //   ),
    );
  }
}
