 
import 'package:attendance2/screen/loginAndRegisterScreen/login_for_student_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
