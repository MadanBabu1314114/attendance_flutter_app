import 'package:attendance2/widget/notification_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../firebase/admin backend/admin_add_notification_backend.dart';

class AdminSendNotification extends StatefulWidget {
  const AdminSendNotification({super.key});

  @override
  State<AdminSendNotification> createState() => _AdminSendNotificationState();
}

class _AdminSendNotificationState extends State<AdminSendNotification> {
  final notificationController = TextEditingController();
  final titleController = TextEditingController();
  var isSubmit = false;
  List<NotificationAdmin> listOfNotifications = [];

  @override
  void dispose() {
    notificationController.dispose();
    titleController.dispose();
    super.dispose();
  }

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

  void showBottomSheetCustom() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      enableDrag: true,
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return SafeArea(
          child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: const Text("Title"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: notificationController,
                    dragStartBehavior: DragStartBehavior.start,
                    scrollController: ScrollController(),
                    decoration: InputDecoration(
                      label: const Text("Notification"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await addNotificationOfAdmin(
                          titleController.text, notificationController.text);
                      if (result) {
                        setState(() {
                          isSubmit = true;
                        });
                        showSnackbarScreen(context, "Sucessfully summited");
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            isSubmit = false;
                            Navigator.of(context).pop();
                          });
                        });
                      }
                    },
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(4),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.notifications_active),
        title: Text("Add Notification"),
        actions: [
          TextButton(
              onPressed: () {
                showBottomSheetCustom();
              },
              child: Icon(Icons.add))
        ],
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
                  ))
            ],
          ),
          if (listOfNotifications.length == 0) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
