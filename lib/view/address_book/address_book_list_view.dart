import 'package:flutter/material.dart';
import 'package:flutter_webview/view/address_book/address_book_detail_list.dart';

class AddressBookListView extends StatefulWidget {
  final Key? textFieldkey;

  const AddressBookListView({super.key, this.textFieldkey});

  @override
  State<AddressBookListView> createState() => _AddressBookListViewState();
}

class _AddressBookListViewState extends State<AddressBookListView> {
  final List<String> items = [
    'Contacts',
    'Global Address List',
    'OGCOI Address Book',
    'OGCOI Address Book - Groups',
    'OGCOI Address Book - People',
    'Whole Governemnt Directory',
    'Whole Governemnt Directory - Group',
    'Whole Governemnt Directory - People',
    'Personal Address Book A'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Book'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                // Handle onTap event for the item
                print('Tapped item: ${items[index]}');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressBookDetailListView(
                          addressBookName: items[index]),
                    ));
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    key: Key('item_$index'),
                    title: Text(items[index]),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0.0,
                    thickness: 0.3,
                  ), //                           <-- Divider
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
