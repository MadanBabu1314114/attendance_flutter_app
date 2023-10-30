import 'package:attendance2/backend/register_with_email_and_password.dart';
import 'package:attendance2/screen/loginAndRegisterScreen/login_for_student_teacher.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:flutter/material.dart';

class AdminAddFaculty extends StatefulWidget {
  const AdminAddFaculty({super.key});

  @override
  State<AdminAddFaculty> createState() => _AdminAddFacultyState();
}

class _AdminAddFacultyState extends State<AdminAddFaculty> {
  final nameContrller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isTeacher = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameContrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTeacher = false;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 190, 220, 230),
                            shape: RoundedRectangleBorder(
                              side: isTeacher
                                  ? const BorderSide(color: Colors.white)
                                  : const BorderSide(
                                      color: Colors.lightBlue, width: 2),
                              borderRadius: const BorderRadius.all(
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
                                const Text("Teacher")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameContrller,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        fillColor: const Color.fromARGB(255, 151, 165, 243)
                            .withOpacity(0.6),
                        label: Text(
                          'Name',
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
                      final result = await register_email_password(context,
                          emailController.text, passwordController.text);
                      if (result) {
                        snackBarUser(context, "Sucessfull");
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
