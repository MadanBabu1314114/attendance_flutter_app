import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/data/data.dart';
import 'package:attendance2/firebase/faculty%20backend/faculty_take_attendance_backend.dart';
import 'package:attendance2/screen/facultyScreens/Faculty%20Attendance/faculty_take_attendance_for_students.dart';
import 'package:attendance2/screen/loginAndRegisterScreen/login_for_student_teacher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../colors data/colors_data.dart';

class FacultyTakeAttendance extends StatefulWidget {
  const FacultyTakeAttendance({super.key});

  @override
  State<FacultyTakeAttendance> createState() => _FacultyTakeAttendanceState();
}

class _FacultyTakeAttendanceState extends State<FacultyTakeAttendance> {
  var selectedBranch;
  var selectedSection;
  var selectedYear;
  var selectedSubject;
  List listOfBranches = [];
  List listOfyears = [];
  List listOfSections = [];
  List listOfSubject = [
    "Communicative English",
    "Mathematics – I",
    "Applied Chemistry",
    "Programming for Problem Solving using C",
    "Computer Engineering Workshop",
    "English Communication Skills Laboratory",
    "Applied Chemistry Lab",
    "Programming for Problem Solving using C Lab",
    "Mathematics – II",
    "Applied Physics",
    "Digital Logic Design",
    "Python Programming",
    "Data Structures",
    "Applied Physics Lab",
    "Python Programming Lab",
    "Data Structures Lab",
    "Mathematics III",
    "Mathematical Foundations of Computer Science",
    "Fundamentals of Data Science",
    "Object Oriented Programming with Java",
    "Database Management Systems",
    "Fundamentals of Data Science Lab",
    "Object Oriented Programming with Java Lab",
    "Database Management Systems Lab",
    "Mobile App Development",
    "Essence of Indian Traditional Knowledge",
    "Probability and Statistics",
    "Computer Organization",
    "Data Warehousing and Mining",
    "Formal Languages and Automata Theory",
    "Managerial Economics and Financial Accountancy",
    "R Programming Lab",
    "Data Mining using Python Lab",
    "Web Application Development Lab",
    "MongoDB",
    "Computer Networks",
    "Big Data Analytics",
    "Design and Analysis of Algorithms",
    "Professional Elective-II",
    "Open Elective-II",
    "Computer Networks Lab",
    "Big Data Analytics Lab",
    "Deep Learning with TensorFlow",
    "Skill Oriented Course - IV",
    "Professional Elective-III",
    "Professional Elective-IV",
    "Professional Elective-V",
    "Open Elective-III",
    "Universal Human Values 2: Understanding Harmony",
    "Major Project Work, Seminar Internship"
  ];

  var str;

  @override
  void initState() {
    listOfSubject.sort();
    takeListOfYears();
    takeListOfBranch();
    takeListOfSection();

    super.initState();
  }

  void takeListOfYears() async {
    await retrieveYears().then((value) {
      setState(() {
        listOfyears = value;
      });
    });
  }

  void takeListOfSection() async {
    await retrieveSections().then((value) {
      setState(() {
        listOfSections = value;
      });
    });
  }

  void takeListOfBranch() async {
    await retrieveBranches().then((value) {
      setState(() {
        listOfBranches = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Faculty Take Attendance"),
        leading: Icon(Icons.book),
        actions: [
          TextButton(
              onPressed: () async {
                await googleSignIn.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                showSnackbarScreen(context, "Successfully Log Out");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => LoginScreen()),
                    (route) => false);
              },
              child: const Text("Sign Out"))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("WELCOME",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "choose your class",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color: lightNavigationbar,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButton(
                          dropdownColor: textColor,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(30),
                          elevation: 10,
                          hint: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Select Year"),
                          ),
                          value: selectedYear,
                          items: listOfyears
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  alignment: Alignment.center,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color: lightNavigationbar,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButton(
                          dropdownColor: textColor,
                          borderRadius: BorderRadius.circular(30),
                          isExpanded: true,
                          elevation: 10,
                          hint: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Select Branch"),
                          ),
                          value: selectedBranch,
                          items: listOfBranches
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  alignment: Alignment.center,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedBranch = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color: lightNavigationbar,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButton(
                          dropdownColor: textColor,
                          borderRadius: BorderRadius.circular(30),
                          isExpanded: true,
                          elevation: 10,
                          hint: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Select Section"),
                          ),
                          value: selectedSection,
                          items: listOfSections
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  alignment: Alignment.center,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSection = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color: lightNavigationbar,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButton(
                          dropdownColor: textColor,
                          borderRadius: BorderRadius.circular(30),
                          isExpanded: true,
                          elevation: 10,
                          hint: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Select Subject"),
                          ),
                          value: selectedSubject,
                          items: listOfSubject
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  alignment: Alignment.center,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSubject = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(buttonColor)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    FacultyTakeAttendanceForStudents(
                                      branch: selectedBranch,
                                      section: selectedSection,
                                      year: selectedYear,
                                      subject: selectedSubject,
                                    )));
                          },
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (listOfSections.length == 0) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
