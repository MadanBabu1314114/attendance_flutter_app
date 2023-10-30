 import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_with_email_and_password.dart';

 


Future<bool> register_email_password(
    BuildContext context, String emailAddress, String password) async {
  try {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      snackBarUser(context, 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      snackBarUser(context, "The account already exists for that email.");
    }
  } catch (e) {
    snackBarUser(context, e.toString());
  }
  return false;
}
