import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/data/data.dart';
import 'package:attendance2/screen/loginAndRegisterScreen/login_for_student_teacher.dart';
import 'package:attendance2/screen/studentScreens/studentNavigationScreens/studentAttendance/student_view_attendance_screen.dart';
import 'package:flutter/material.dart';
import '../../../colors data/colors_data.dart';
import '../../../firebase/faculty backend/faculty_take_attendance_backend.dart';

class StudentViewTodayAttendance extends StatefulWidget {
  const StudentViewTodayAttendance({super.key});

  @override
  State<StudentViewTodayAttendance> createState() =>
      _StudentViewTodayAttendanceState();
}

class _StudentViewTodayAttendanceState
    extends State<StudentViewTodayAttendance> {
  var selectedBranch;
  var selectedSection;
  var selectedYear;
  var selectedSubject;
  List listOfBranches = [];
  List listOfyears = [];
  var period;
  List listOfSections = [];

  @override
  void initState() {
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
          title: const Text("Student Take Today Attendance"),
          actions: [
            TextButton(
                onPressed: () async {
                  await googleSignIn.signOut();
                  showSnackbarScreen(context, "Successfully sign out");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text('Sign out'))
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
                            elevation: 10,
                            isExpanded: true,
                            hint: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Select period"),
                            ),
                            value: period,
                            items: [
                              'period1',
                              'period2',
                              'period3',
                              'period4',
                              'period5',
                              'period6',
                              'period7',
                              'period8'
                            ]
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
                                period = value.toString();
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
                                  builder: (ctx) => StudentViewAttendanceScreen(
                                        branch: selectedBranch,
                                        section: selectedSection,
                                        year: selectedYear,
                                        period: period,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (listOfSections.length == 0) CircularProgressIndicator()
            ],
          ),
        ));
  }
}
