import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webview/model/mail_list_item_obj.dart';
import 'package:flutter_webview/view/compose_mail_view.dart';
import 'package:flutter_webview/view/read_mail_view.dart';
import 'package:flutter_webview/view/ui/home/home_app_bar.dart';
import 'package:flutter_webview/view/ui/home/home_compose_floating_action_button.dart';
import 'package:flutter_webview/view/ui/mail/mail_list_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _scrollController = ScrollController();
  bool isScrolledUp = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
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
          appBar: const HomeAppBar(),
          drawer: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Set borderRadius to zero
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // const DrawerHeader(
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //   ),
                //   child: Text('Drawer Header'),
                // ),
                const ListTile(
                  title: Text(
                    'Secure Message Application',
                    style: TextStyle(
                      color: Colors.blue, // Set the desired text color here
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('Compose'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: const Text('Inbox'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.drafts),
                  title: const Text('Drafts'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.send),
                  title: const Text('Sent Items'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.error_outline),
                  title: const Text('Span Items'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Deleted Items'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          floatingActionButton: HomeComposeFAB(
            isScrolledUp: isScrolledUp,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComposeMailView(),
                ),
              );
            },
          ),
          body: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              MailListItem(
                  mailListItemDataObj: MailListItemDataObj(
                      "", "Kars", "Men accused of killing 3,600 birds including eagles", "Simon Paul and Travis John Branson allegedly shot the birds over several years and sold parts and feathers on the black market.", false, DateTime.now()),
                  onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReadMailView(),
                    ));
              }),
              MailListItem(
                  mailListItemDataObj: MailListItemDataObj("", "Joseph Joestar", "Today News",
                      "How are you?", true, DateTime.now()), onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReadMailView(),
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        isScrolledUp = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        isScrolledUp = true;
      });
    }
  }
}
