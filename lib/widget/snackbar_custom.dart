import 'package:flutter/material.dart';

void snackBarUser(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
       elevation: 4,
       action: SnackBarAction(label: "Undo", onPressed: (){
        Navigator.of(context).pop();
       }),
      content: Text(message),
    ),
  );
}
