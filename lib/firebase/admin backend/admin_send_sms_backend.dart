import '../../screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'admin_add_branch_backend.dart';

Future<List<Student>> findTheTwoPeriodsAttendanceStudentsInFirebase(
    String date, List<Student> listOfStudents) async {
  final studentDailyDatabase = database.child('/Daily attendance/$date');

  // Create a list of Futures for the database queries
  List<Future<void>> databaseQueries = [];
  var listOfPeriods = [
    'period1',
    'period2',
    'period3',
    'period4',
    'period5',
    'period6',
    'period7',
    'period8'
  ];

  List<Student> studentTwoPeriodsAbsentList = [];

  for (var i = 0; i < listOfStudents.length; i++) {
    // Add each database query to the list
    var count = 0;
    for (var j = 0; j < listOfPeriods.length; j++) {
      databaseQueries.add(studentDailyDatabase
          .child("${listOfStudents[i].roll_number}/${listOfPeriods[j]}")
          .once()
          .then((value) {
        final attendanceList = value.snapshot.value as Map;
        attendanceList.forEach((key, value) {
          if (key == "attendance" && value == false) {
            count++;
            if (count == 2) {
              studentTwoPeriodsAbsentList.add(listOfStudents[i]);
              print(listOfStudents[i].name);
            }
          }
        });
      }));
    }
  }
  // Wait for all database queries to complete
  try {
    await Future.wait(databaseQueries);
  } catch (e) {}

  return studentTwoPeriodsAbsentList;
}
