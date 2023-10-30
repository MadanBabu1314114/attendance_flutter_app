
import 'package:firebase_auth/firebase_auth.dart';

import '../../globalData/global.dart';

Future<String> loginbackend(String email, String password) async {
  try {
    final credential = await firebase.signInWithEmailAndPassword(
        email: email, password: password);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    }
  }
  return 'error';
}
