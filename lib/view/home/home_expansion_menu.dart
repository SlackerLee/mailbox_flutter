import 'package:flutter/material.dart';
import 'package:flutter_webview/view/compose_mail_view.dart';

class HomeExpansionMenu extends StatefulWidget {
  const HomeExpansionMenu({Key? key}) : super(key: key);

  @override
  _HomeExpansionMenuState createState() => _HomeExpansionMenuState();
}

class _HomeExpansionMenuState extends State<HomeExpansionMenu> {
  bool confidentialExpanded = true;
  bool restrictedExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero, children: [
      const ListTile(
        title: Text(
          'Secure Message Application',
          style: TextStyle(
            color: Colors.blue, // Set the desired text color here
          ),
        ),
      ),
      const Divider(),
      // const DrawerHeader(
      //   decoration: BoxDecoration(
      //     color: Colors.blue,
      //   ),
      //   child: Text('Drawer Header'),
      // ),
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          ExpansionTile(
            leading: const Icon(Icons.mail_lock),
            title: const Text('Confidential Mail'),
            iconColor: Colors.blue,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: const Text('Compose'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ComposeMailView(mailType: 'C',),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Indeox'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.drafts),
                title: const Text('Drafts'),
                onTap: () {},
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.mail_lock_outlined),
            title: const Text('Restricted Mail'),
            iconColor: Colors.blue,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: const Text('Compose'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ComposeMailView(mailType: 'R',),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Indeox'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.drafts),
                title: const Text('Drafts'),
                onTap: () {},
              ),
            ],
          )
        ],
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
    ]);
  }
}
