import 'package:attendance2/widget/notification_card.dart';
import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../firebase/admin backend/admin_add_notification_backend.dart';

class StudentViewNotification extends StatefulWidget {
  const StudentViewNotification({super.key});

  @override
  State<StudentViewNotification> createState() => _StudentViewNotificationState();
}

class _StudentViewNotificationState extends State<StudentViewNotification> {
    List<NotificationAdmin> listOfNotifications = [];
  @override
  void initState() {
    getNotification();
    super.initState();
  }

  void getNotification() async {
    await retrieveNotificationForStudent().then((value) {
      setState(() {
        listOfNotifications = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student View Notification"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
               ...listOfNotifications.map((e) => NotificationCard(
                    title: e.title,
                    date: e.date,
                    note: e.note,
                  )),
                     
            ],
          ),
          if(listOfNotifications.length == 0 ) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
