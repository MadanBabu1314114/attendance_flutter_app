import 'package:attendance2/backend/login_with_email_and_password.dart';
import 'package:attendance2/firebase/faculty%20backend/faculty_take_attendance_backend.dart';
import 'package:attendance2/firebase/student%20backend/student_view_attendance_backend.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:attendance2/screen/facultyScreens/faculty_navigation_screen.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:attendance2/widget/student_card.dart';
import 'package:flutter/material.dart';


class FacultyUpdateAttendanceForStudents extends StatefulWidget {
  const FacultyUpdateAttendanceForStudents({
    super.key,
    required this.branch,
    required this.section,
    required this.year,
    required this.subject,
    required this.period,
    required this.selectedDate,
  });
  final String branch;
  final String section;
  final String year;
  final String subject;
  final String period;
  final String selectedDate;

  @override
  State<FacultyUpdateAttendanceForStudents> createState() =>
      _FacultyUpdateAttendanceForStudentsState();
}

class _FacultyUpdateAttendanceForStudentsState
    extends State<FacultyUpdateAttendanceForStudents> {
 
  List<Student> listOfStudents = [];
  bool studentIsPresent = true;
  List<Student> studentAbsentList = [];
  var isUploading = false;

  @override
  void initState() {
    retrieveStudentForTakeAttendance();
    super.initState();
  }

  void retrieveStudentForTakeAttendance() async {
    await retrieveStudentFromYearBranchSection(
      widget.branch,
      widget.section,
      widget.year,
    ).then((value) {
      setState(() {
        listOfStudents = value;
        retreieveStudentAbsentList(widget.period, widget.selectedDate);
      });
    });
  }

  void retreieveStudentAbsentList(String period, String selectedDate) async {
    await retrieveAttendanceForPeriodDateListStudent(
            period, selectedDate, listOfStudents)
        .then((value) {
      setState(() {
        studentAbsentList = value;
      });
    });
     
  }

  void uploadTheDataIntoFirebase() async {
    print(studentAbsentList);
    print(widget.selectedDate);
    print(widget.period);
    print(widget.subject);
     
    listOfStudents
        .removeWhere((element) => studentAbsentList.contains(element));
    uploadAttendanceForStudent(
      widget.selectedDate,
      widget.period,
      widget.subject,
      firebaseAuth.currentUser!.email!,
      studentAbsentList,
      listOfStudents,
    );
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (listOfStudents.length != 0 &&
                      studentAbsentList.length != 0)
                    ...listOfStudents.map((student) {
                      return StudentCard(
                        key: GlobalKey(),
                        student: student,
                        studentIsPresent: !studentAbsentList.contains(student),
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
