import 'package:attendance2/data/data.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final googleSignIn = GoogleSignIn();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 

Future<bool> login_email_password(
  BuildContext context,
  String emailAddress,
  String password,
) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      snackBarUser(context, 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      snackBarUser(context, 'Wrong password provided for that user.');
    } else {
      snackBarUser(context, e.toString());
    }
  }
  return false;
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  var credential;
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  } catch (e) {
    showSnackbarScreen(context, e.toString());
  }
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
