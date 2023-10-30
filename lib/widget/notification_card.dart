import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../firebase/admin backend/admin_add_notification_backend.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {super.key, required this.title, required this.date, required this.note});
  final String title;
  final String date;
  final String note;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          color: lightNavigationbar,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: ExpansionTile(
          title: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: textColor),
              ),
              Text(widget.date)
            ],
          ),
          leading: const Icon(Icons.notifications_active),
          expandedAlignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.note,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.deepPurple),
                softWrap: true,
                 textAlign: TextAlign.left,
                 overflow: TextOverflow.fade,
              ),
            )
          ],
          
        ),
      ),
    );
  }
}
