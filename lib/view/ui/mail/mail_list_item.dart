import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MailListItem extends StatelessWidget {
  final String avatar;
  final String title;
  final String subtitle;
  final bool isStared;
  final DateTime date;
  final VoidCallback onTap;

  const MailListItem(this.avatar, this.title, this.subtitle, this.isStared,
      this.date, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd yyyy hh:mm').format(date);
    final firstLetter = avatar.isNotEmpty ? avatar[0] : '';

    return GestureDetector(
      onTap: onTap, // Provide the onTap callback
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Text(
              firstLetter,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  date.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
