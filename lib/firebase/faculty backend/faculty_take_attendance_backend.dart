import '../../data/data.dart';
import '../../screen/adminScreens/adminNavigationScreens/add_branches.dart';
import '../admin backend/admin_add_branch_backend.dart';

Future<List<String>> retrieveYears() async {
  final yearDataBase = await database.child('years').orderByKey().once();
  final years = yearDataBase.snapshot.value as Map;
  List<String> yearsList = [];
  years.forEach(
    (key, value) {
      yearsList.add(key);
    },
  );

  return yearsList;
}

Future<List<String>> retrieveSections() async {
  final sectionDataBase = await database.child('sections').orderByKey().once();
  final years = sectionDataBase.snapshot.value as Map;
  List<String> sectionList = [];
  years.forEach(
    (key, value) {
      sectionList.add(key);
    },
  );

  return sectionList;
}

Future<List<String>> retrieveBranches() async {
  final branchDatabase = database.child('/branches');
  final branchData = await branchDatabase.once();
  final branchList = branchData.snapshot.value as Map;
  final List<Branch> branches = [];
  branchList.forEach((key, value) {
    branches.add(Branch(value['name']));
  });

  final List<String> listOfBranchNames = [];
  for (var branch in branches) {
    listOfBranchNames.add(branch.name);
  }

  return listOfBranchNames;
}

Future<List<Student>> retrieveStudentFromYearBranchSection(
    String branch, String section, String year) async {
  final studentDatabase = database.child('students');
  final studentData1 =
      await studentDatabase.orderByChild('section_id').equalTo(section).once();
  final studentList = studentData1.snapshot.value as Map;
  final List<Student> students = [];
  studentList.forEach((key, value) {
    
    if (value['branch_id'].toString() == branch) {
      if (value['year'].toString() == year) {
        students.add(
          Student(
              value['name'],
              value['roll_number'],
              value['section_id'],
              value['year'],
              value['branch_id'],
              value['phone_number1'],
              value['phone_number2']),
        );
      }
    }
  });

  students.sort((a, b) =>
      a.roll_number.substring(7, 10).compareTo(b.roll_number.substring(7, 10)));

  return students;
}

void uploadAttendanceForStudent(
    String date,
    String period,
    String subject,
    String teacherName,
    List<Student> absentStudents,
    List<Student> presentStudents) async {
  final attendanceDatabase = database.child('/Daily attendance/$date');

  for (var student in presentStudents) {
    final studentAttendanceDatabase =
        attendanceDatabase.child('${student.roll_number}');
    final attendancePeriodDatabase = studentAttendanceDatabase.child(period);

    attendancePeriodDatabase.set({
      'subject': subject,
      'teacher': teacherName,
      'attendance': true,
    });
  }

  for (var student in absentStudents) {
    final studentAttendanceDatabase =
        attendanceDatabase.child('${student.roll_number}');
    final attendancePeriodDatabase = studentAttendanceDatabase.child(period);

    attendancePeriodDatabase.set({
      'subject': subject,
      'teacher': teacherName,
      'attendance': false,
    });
  }
}
