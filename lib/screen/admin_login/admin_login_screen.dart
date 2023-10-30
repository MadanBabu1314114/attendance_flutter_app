import 'package:attendance2/data/data.dart';
import 'package:attendance2/screen/adminScreens/admin_navigation_screen.dart';
import 'package:flutter/material.dart';

import '../../backend/login_with_email_and_password.dart';
import '../../widget/snackbar_custom.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var isTeacher = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Hello again!",
                      style: TextStyle(
                          color: Color.fromRGBO(83, 88, 171, 1),
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const Text("Welcome",
                      style: TextStyle(
                          color: Color.fromRGBO(83, 88, 171, 1),
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const Text("Admin",
                      style: TextStyle(
                          color: Color.fromRGBO(83, 88, 171, 1),
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 190, 220, 230),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.lightBlue, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                'https://static-00.iconduck.com/assets.00/teacher-illustration-1001x1024-plu4q319.png',
                                width: 150,
                                height: 150,
                              ),
                              const Text("Admin")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        fillColor: const Color.fromARGB(255, 151, 165, 243)
                            .withOpacity(0.6),
                        label: Text(
                          'Email',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.8)),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 194, 163, 235),
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      fillColor: const Color.fromARGB(255, 151, 165, 243)
                          .withOpacity(0.6),
                      label: Text(
                        'Password',
                        style: TextStyle(color: Colors.black.withOpacity(0.8)),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 194, 163, 235),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  FilledButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 56, 109, 221))),
                    onPressed: () async {
                      if (emailController.text == "gaddiparthimadanbabu@gmail.com" || emailController.text == "vksai17@gmail.com") {
                        final result = await login_email_password(context,
                            emailController.text, passwordController.text);
                        if (result) {
                          snackBarUser(context, "Successfull");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    const AdminNavigationScreen()),
                          );
                        }
                      } else {
                        showSnackbarScreen(context, "Enter Correct Email");
                      }
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 56, 109, 221))),
                        child: const Text("Forgot your password?"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
