import 'package:attendance2/data/data.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';

void showSnackbarScreen1(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: buttonLight),
      ),
      backgroundColor: lightVoilate,
      duration: const Duration(seconds: 2),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
