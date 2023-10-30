import 'package:flutter/material.dart';

class BottomIcon {
  final String name;
  final IconData icon1;
  final IconData icon2;
  BottomIcon(this.name, this.icon1, this.icon2);
}

Color mediumColor = Color.fromRGBO(83, 88, 171, 1);

class Branch {
  final String name;
  Branch(this.name);
}

class NotificationAdmin {
  final String title;
  final String date;
  final String note;

  NotificationAdmin(
    this.title,
    this.date,
    this.note,
  );
}

void showSnackbarScreen(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar( elevation: 4, content: Text(message)));
}
