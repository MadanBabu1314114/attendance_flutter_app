import 'package:firebase_database/firebase_database.dart';

import '../../data/data.dart';
import '../../screen/adminScreens/adminNavigationScreens/add_branches.dart';

final database = FirebaseDatabase.instance
    .refFromURL('https://flutterauth-d3598-default-rtdb.firebaseio.com/');

Future<bool> addBranchYearSectionFromExcel(Student student) async {
  final branchDataBase =
      database.child('/branches/${student.year}-${student.branch_id}');
  await branchDataBase.set({'name': '${student.year}-${student.branch_id}'});

  final sectionDatabase =
      database.child("/sections/${student.section_id}/${student.branch_id}");
  await sectionDatabase.set({
    "brach_id": student.branch_id,
    'name': student.section_id,
  });

  final studentDatabase = database.child('/students/${student.roll_number}');
  await studentDatabase.set({
    'name': student.name,
    'roll_number': student.roll_number,
    'section_id': student.section_id,
    'year': student.year,
    'branch_id': '${student.year}-${student.branch_id}',
    "phone_number1": student.phone_number1,
    'phone_number2': student.phone_number2
  });

  final yearDataBase = database.child('years/${student.year}');
  await yearDataBase.set({'name': student.year});

  return true;
}

Future<List<Branch>> retrieveBranches() async {
  print("Madan");
  final branchDatabase = database.child('/branches');
  final branchData = await branchDatabase.once();
  final branchList = branchData.snapshot.value as Map;
  final List<Branch> branches = [];
  branchList.forEach((key, value) {
    branches.add(Branch(value['name']));
  });

  return branches;
}


void addFacultyIntoTheFirebase(String username, String email) async {
  final facultyDatabase = database.child("faculty/$username-email");
  await facultyDatabase.set({'username': username, 'email': email});
}



Stream<List<Faculty>> retrieveFacultyFromFirebase() {
  final reference =  database.child('faculty');

  return reference.onValue.map((event) {
    if (event.snapshot.value != null) {
      final Map<dynamic, dynamic> facultyData = event.snapshot.value as Map;
      List<Faculty> facultyList = [];

      facultyData.forEach((key, value) {
        final faculty = Faculty(
          email: value['email'],
          username: value['username'],
        );
        facultyList.add(faculty);
      });

      return facultyList;
    } else {
      return [];
    }
  });
}

class Faculty {
  final String email;
  final String username;

  Faculty({required this.email, required this.username});
}
