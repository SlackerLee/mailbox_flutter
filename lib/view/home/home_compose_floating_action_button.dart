import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_webview/view/compose_mail_view.dart';

class HomeComposeFAB extends StatelessWidget {
  final bool isScrolledUp;

  const HomeComposeFAB({super.key, required this.isScrolledUp});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      label: isScrolledUp ? const Text("Compose") : null,
      child: Icon(Icons.edit),
      spaceBetweenChildren: 15,
      overlayOpacity: 0.5,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.mail_lock),
          label: 'Restricted Mail',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ComposeMailView(mailType: 'R',),
              ),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.mail_lock_outlined),
          label: 'Confidential Mail',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ComposeMailView(mailType: 'C',),
              ),
            );
          },
        ),
      ],
    );
  }
}
