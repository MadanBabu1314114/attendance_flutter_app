import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/firebase/faculty%20backend/faculty_take_attendance_backend.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:attendance2/screen/facultyScreens/faculty_navigation_screen.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:attendance2/widget/student_attendance_view_card.dart';
import 'package:attendance2/widget/student_card.dart';
import 'package:flutter/material.dart';

import '../../../colors data/colors_data.dart';

class FacultyTakeAttendanceForStudents extends StatefulWidget {
  const FacultyTakeAttendanceForStudents({
    super.key,
    required this.branch,
    required this.section,
    required this.year,
    required this.subject,
  });
  final String branch;
  final String section;
  final String year;
  final String subject;

  @override
  State<FacultyTakeAttendanceForStudents> createState() =>
      _FacultyTakeAttendanceForStudentsState();
}

class _FacultyTakeAttendanceForStudentsState
    extends State<FacultyTakeAttendanceForStudents> {
  var period;
  final dateTime = DateTime.now();
  var selectedDate;
  List<Student> listOfStudents = [];
  bool studentIsPresent = true;
  List<Student> studentAbsentList = [];
  var isUploading = false;

  @override
  void initState() {
    retrieveStudentForTakeAttendance();
    selectedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    super.initState();
  }

  void showCalender() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        selectedDate = "${value!.day}-${value.month}-${value.year}";
      });
    });
  }

  void retrieveStudentForTakeAttendance() async {
    await retrieveStudentFromYearBranchSection(
      widget.branch,
      widget.section,
      widget.year,
    ).then((value) {
      setState(() {
        listOfStudents = value;
      });
    });
  }

   

  void uploadTheDataIntoFirebase() async {
    listOfStudents
        .removeWhere((element) => studentAbsentList.contains(element));
    uploadAttendanceForStudent(selectedDate, period, widget.subject,
        firebaseAuth.currentUser!.email!, studentAbsentList, listOfStudents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.branch),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isUploading = true;
                  });
                  uploadTheDataIntoFirebase();
                  setState(() {
                    isUploading = false;
                  });
                  snackBarUser(context, "Attendance Successful");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => const FacultyNavigationScreen()));
                  
                },
                child: const Text("Submit"))
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          showCalender();
                        },
                        label: Text(
                          selectedDate.toString() == 'null'
                              ? "Select date"
                              : selectedDate.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        icon: Icon(Icons.calendar_today),
                      ),
                      Expanded(
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (listOfStudents.length != 0)
                    ...listOfStudents.map((student) {
                      return StudentCard(
                        key: GlobalKey(),
                        student: student,
                        studentIsPresent: studentIsPresent,
                        studentAbsentList: studentAbsentList,
                      );
                    }),
                ],
              ),
            ),
            if (listOfStudents.length == 0) const CircularProgressIndicator(),
            if (isUploading) const CircularProgressIndicator()
          ],
        ));
  }
}
