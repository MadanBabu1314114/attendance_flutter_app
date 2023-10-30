import 'dart:async';

import 'package:attendance2/firebase/admin%20backend/admin_add_branch_backend.dart';

import '../../screen/adminScreens/adminNavigationScreens/add_branches.dart';

Future<List<Student>> retrieveAttendanceForPeriodDateListStudent(
    String period, String date, List<Student> listOfStudents) async {
  List<Student> studentAbsentList = [];
  final studentDailyDatabase = database.child('/Daily attendance/$date');

  // Create a list of Futures for the database queries
  List<Future<void>> databaseQueries = [];

  for (var i = 0; i < listOfStudents.length; i++) {
    // Add each database query to the list
    databaseQueries.add(studentDailyDatabase
        .child("${listOfStudents[i].roll_number}/$period")
        .once()
        .then((value) {
          final attendanceList = value.snapshot.value as Map;
          attendanceList.forEach((key, value) {
            if (key == "attendance" && value == false) {
              studentAbsentList.add(listOfStudents[i]);
            }
          });
        }));
  }

  // Wait for all database queries to complete
  await Future.wait(databaseQueries);
  
  return studentAbsentList;
}

