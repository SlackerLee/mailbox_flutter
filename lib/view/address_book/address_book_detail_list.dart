import 'package:flutter/material.dart';
import 'package:flutter_webview/model/address_book/address_book_detail_item_obj.dart';
import 'package:flutter_webview/view/address_book/address_book_detail_item.dart';
import 'package:flutter_webview/view/user_info_view.dart';

class AddressBookDetailListView extends StatefulWidget {
  final String addressBookName;

  const AddressBookDetailListView({super.key, required this.addressBookName});

  @override
  State<AddressBookDetailListView> createState() =>
      _AddressBookDetailListViewState();
}

class _AddressBookDetailListViewState extends State<AddressBookDetailListView> {
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  // TODO: this demo data
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
    AddressBookDetailItemDataObj(
        "User D/OGCIO", "", "Analyst Programmer", "3847 XXXX", "OGCIO")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: !_searchBoolean
                ? Text(widget.addressBookName)
                : _searchTextField(),
            actions: !_searchBoolean
                ? [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = true;
                            _searchIndexList = [];
                          });
                        })
                  ]
                : [
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = false;
                          });
                        })
                  ]),
        body: !_searchBoolean ? _defaultListView() : _searchListView()
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

  Widget _searchTextField() {
    return Container(
      decoration: BoxDecoration(
          // TODO: ui design
          // color: const Color.fromARGB(255, 246, 246, 246),
          // borderRadius: BorderRadius.circular(32),
          ),
      child: TextField(
        onChanged: (String s) {
          setState(() {
            _searchIndexList = [];
            // for (int i = 0; i < _list.length; i++) {
            //   if (_list[i].contains(s)) {
            //     _searchIndexList.add(i);
            //   }
            // }
          });
        },
        autofocus: true,
        cursorColor: Colors.grey,
        style: const TextStyle(
          color: Colors.grey,
          // fontSize: 15,
        ),
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          contentPadding: EdgeInsets.all(20),
          hintStyle: TextStyle(
            color: Colors.grey,
            // fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _defaultListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
            onLongPress: () {
              // TODO
            },
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoView(
                      addressBookDetailDataObj: items[index],
                    ),
                  ));
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
    );
  }

  Widget _searchListView() {
    // TODO
    return ListView.builder(
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
    );
  }
}
