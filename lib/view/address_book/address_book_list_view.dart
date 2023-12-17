import 'package:flutter/material.dart';
import 'package:flutter_webview/view/address_book/address_book_detail_list.dart';

class AddressBookListView extends StatefulWidget {
  final Key? textFieldkey;

  const AddressBookListView({super.key, this.textFieldkey});

  @override
  State<AddressBookListView> createState() => _AddressBookListViewState();
}

class _AddressBookListViewState extends State<AddressBookListView> {
  bool _searchBoolean = false;
  List<int> _searchIndexList = []; 

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
          title: !_searchBoolean ? Text("Address Book") : _searchTextField(),
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
      body:  !_searchBoolean ? _defaultListView() : _searchListView()
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
            for (int i = 0; i < items.length; i++) {
              if (items[i].contains(s)) {
                _searchIndexList.add(i);
              }
            }
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
    );
  }

  Widget _searchListView() {
    // TODO
    return ListView.builder(
      itemCount: _searchIndexList.length,
      itemBuilder: (context, index) {
        index = _searchIndexList[index];
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
    );
  }
}
