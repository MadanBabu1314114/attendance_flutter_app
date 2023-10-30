import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/screen/facultyScreens/faculty_navigation_screen.dart';
import 'package:attendance2/screen/loginAndRegisterScreen/login_for_student_teacher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(MaterialApp(
    theme: ThemeData().copyWith(useMaterial3: true),
    home: FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return snapshot.data == true ? FacultyNavigationScreen() : LoginScreen();
        }
      },
    ),
  ));
}
