import 'package:attendance2/data/data.dart';
 
import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../widget/teacher_student_login_register_card.dart';
import 'login_backend.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello again!",
                            style: TextStyle(
                                color: headlineColorLight,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                                color: headlineColorLight,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                                color: headlineColorLight,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginCard(
                        imageAsset: "assets/icons8-admin-94.png",
                        head: "Admin",
                        value: true,
                        updateValue: (bool) {},
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: ShapeDecoration(
                    color: lightVoilate,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  decoration: ShapeDecoration(
                    color: lightVoilate,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                FilledButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8)),
                    backgroundColor: MaterialStatePropertyAll(buttonLight),
                  ),
                  onPressed: () async {
                    if (emailController.text.length != 0 &&
                        passwordController.text.length != 0) {
                      final result = await loginbackend(
                        emailController.text,
                        passwordController.text,
                      );
                      if (result == "Success") {
                        showSnackbarScreen(context, "Success");
                      } else {
                        showSnackbarScreen(context, result);
                      }
                    } else {
                      showSnackbarScreen(context, "Invaild");
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
                            Color.fromARGB(255, 56, 109, 221)),
                      ),
                      child: const Text("Forgot your password?"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
