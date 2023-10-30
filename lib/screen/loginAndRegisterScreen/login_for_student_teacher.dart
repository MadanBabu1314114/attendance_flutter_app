import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/data/data.dart';
import 'package:attendance2/screen/admin_login/admin_login_screen.dart';
import 'package:attendance2/screen/facultyScreens/faculty_navigation_screen.dart';
import 'package:attendance2/screen/loginAndRegisterScreen/signup_screen.dart';
import 'package:attendance2/screen/studentScreens/studentNavigationScreens/student_view_notification.dart';
import 'package:attendance2/screen/studentScreens/student_navigation_screen.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AdminLoginScreen()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              child: Text(
                "Admin",
                style: TextStyle(color: mediumColor),
              ),
            ),
          ),
        ],
      ),
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
                  const Text("Back",
                      style: TextStyle(
                          color: Color.fromRGBO(83, 88, 171, 1),
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTeacher = false;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 190, 220, 230),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTeacher = true;
                          });
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Color.fromARGB(255, 190, 220, 230),
                            shape: RoundedRectangleBorder(
                              side: !isTeacher
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
                                  "https://cdn-icons-png.flaticon.com/512/2784/2784403.png",
                                  width: 150,
                                  height: 150,
                                ),
                                Text("Student")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  !isTeacher
                      ? Container(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                    fillColor:
                                        const Color.fromARGB(255, 151, 165, 243)
                                            .withOpacity(0.6),
                                    label: Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 194, 163, 235),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                  fillColor:
                                      const Color.fromARGB(255, 151, 165, 243)
                                          .withOpacity(0.6),
                                  label: Text(
                                    'Password',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 194, 163, 235),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                width: double.infinity,
                                child: FilledButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromARGB(255, 56, 109, 221))),
                                  onPressed: () async {
                                    final result = await login_email_password(
                                        context,
                                        emailController.text,
                                        passwordController.text);
                                    if (result) {
                                      snackBarUser(context, "Successfull");
                                      if (!isTeacher) {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setBool('isLoggedIn', true);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                   const  FacultyNavigationScreen()));
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const StduentNavigationScreen()));
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
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
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 56, 109, 221))),
                                    child: const Text("Forgot your password?"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                final credentials =
                                    await signInWithGoogle(context);
                                if (credentials != null) {
                                  showSnackbarScreen(context,
                                      "Successfully Login with Google");
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StduentNavigationScreen()));
                                } else {
                                  showSnackbarScreen(context, "Invaild");
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                  Image.network(
                                    "https://1000logos.net/wp-content/uploads/2021/05/Google-logo.png",
                                    width: 60,
                                    height: 60,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
