import 'package:flutter/material.dart';

class AddressBookListView extends StatefulWidget {
  final Key? textFieldkey;

  const AddressBookListView({super.key, this.textFieldkey});

  @override
  State<AddressBookListView> createState() => _AddressBookListViewState();
}

class _AddressBookListViewState extends State<AddressBookListView> {
  ScrollController _scrollController = ScrollController();
  bool isScrolledUp = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the desired background color
      child: SafeArea(
        child: Scaffold(
          appBar:  AppBar(
        title: const Text('Address Book'),
        backgroundColor: Colors.white,
      ),
          body: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
             
            ],
          ),
        ),
      ),
    );
  }

  

}
