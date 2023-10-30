import 'package:attendance2/data/data.dart';
 
import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../widget/snackbar_of_screen.dart';
import '../../widget/teacher_student_login_register_card.dart';
import 'register_backend.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isStudent = false;

  void updateTeacher(bool value) {
    setState(() {
      isStudent = value;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello!",
                          style: TextStyle(
                              color: headlineColorLight,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Text("Signup to Get",
                          style: TextStyle(
                              color: headlineColorLight,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                      Text("Started",
                          style: TextStyle(
                              color: headlineColorLight,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      LoginCard(
                        color: isStudent == false ? buttonLight : Colors.white,
                        value: true,
                        updateValue: updateTeacher,
                        head: "Teacher",
                        imageAsset: "assets/icons8-teacher-94.png",
                        key: GlobalKey(),
                      ),
                      const Spacer(),
                      LoginCard(
                        color: isStudent == true ? buttonLight : Colors.white,
                        updateValue: updateTeacher,
                        value: false,
                        head: "Student",
                        imageAsset: "assets/icons8-student-94.png",
                        key: GlobalKey(),
                      ),
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
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.contact_emergency,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                            borderRadius: BorderRadius.circular(20))),
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
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                FilledButton(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 8)),
                      backgroundColor: MaterialStatePropertyAll(buttonLight)),
                  onPressed: () async {
                    if (emailController.text.length != 0 &&
                        passwordController.text.length != 0) {
                      final result = await registerBackEnd(
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
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 56, 109, 221))),
                      child: const Text("Alread have an account"),
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
