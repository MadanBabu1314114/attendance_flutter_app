import '../../screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'admin_add_branch_backend.dart';
Future<Map<Student, List<String>>> retrieveStudentsPeriodAttendance(
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

  Map<Student, List<String>> studentPeriodAttendanceMap = {};

  for (var i = 0; i < listOfStudents.length; i++) {
    // Initialize attendance list for each student
    List<String> attendance = [];

    for (var j = 0; j < listOfPeriods.length; j++) {
      final period = listOfPeriods[j];
      final student = listOfStudents[i];

      databaseQueries.add(studentDailyDatabase
          .child("${student.roll_number}/$period")
          .once()
          .then((value) {
        final attendanceData = value.snapshot.value as Map<dynamic, dynamic>;
        if (attendanceData != null && attendanceData.containsKey('attendance')) {
          final periodAttendance = attendanceData['attendance'];
          attendance.add(periodAttendance.toString()); // Assuming attendance is stored as a boolean
        }
        
        
      }));
    }

    // Wait for all database queries for this student to complete
     try {
       await Future.wait(databaseQueries);
     } catch (e) {
       
     }

    // Add the attendance list for this student to the map
    studentPeriodAttendanceMap[listOfStudents[i]] = attendance;

    // Clear the databaseQueries list for the next student
    databaseQueries.clear();
  }

  return studentPeriodAttendanceMap;
}
