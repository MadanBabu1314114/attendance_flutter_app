import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:attendance2/firebase/faculty%20backend/faculty_take_attendance_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../firebase/admin backend/admin_view_students_attendance_table_backend.dart';
import 'adminNavigationScreens/add_branches.dart';

class AdminViewStudentsAttendanceTable extends StatefulWidget {
  const AdminViewStudentsAttendanceTable({
    super.key,
    required this.branch,
    required this.section,
    required this.year,
  });

  final String branch;
  final String section;
  final String year;

  @override
  State<AdminViewStudentsAttendanceTable> createState() =>
      _AdminViewStudentsAttendanceTableState();
}

class _AdminViewStudentsAttendanceTableState
    extends State<AdminViewStudentsAttendanceTable> {
  Map<Student, List<String>> listOFStudentAttendanceInformation = {};
  List<Student> listOfStudents = [];

  @override
  void initState() {
    retrieveStudent();
    super.initState();
  }

  void retrieveStudent() async {
    await retrieveStudentFromYearBranchSection(
      widget.branch,
      widget.section,
      widget.year,
    ).then((value) {
      setState(() {
        listOfStudents = value;
        retrieveStudentInformation(value);
      });
    });
  }

  void retrieveStudentInformation(List<Student> listStudentForFunction) async {
    final dateTime = DateTime.now();
    await retrieveStudentsPeriodAttendance(
            '${dateTime.day}-${dateTime.month}-${dateTime.year}',
            listStudentForFunction)
        .then((value) {
      setState(() {
        listOFStudentAttendanceInformation = value;
      });
    });
    print(listOFStudentAttendanceInformation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin View Student Attendance Table"),
        leading: Icon(Icons.table_bar),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (listOFStudentAttendanceInformation.length != 0)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: DataTable(
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(10),
                              color: lightNavigationbar),
                          columns: [
                            DataColumn(
                                label: Text(
                              'Student',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                            ...[
                              'period1',
                              'period2',
                              'period3',
                              'period4',
                              'period5',
                              'period6',
                              'period7',
                              'period8'
                            ].map(
                              (e) => DataColumn(
                                label: Text(
                                  e.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                          rows: [
                            ...listOFStudentAttendanceInformation.entries.map((e) {
                              return DataRow(
                                cells: [
                                  DataCell(Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.key.roll_number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Text(e.key.name , style: Theme.of(context).textTheme.labelMedium,)
                                    ],
                                  )),
                                  ...e.value.map(
                                    (e) => DataCell(Container(
                                        width: double.infinity,
                                        height: 50,
                                        color: e == 'true'
                                            ? Colors.green.shade300
                                            : Colors.red.shade200,
                                        child: Text(
                                          e == 'true' ? "P" : "A",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!,
                                          textAlign: TextAlign.center,
                                        ))),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          if(listOFStudentAttendanceInformation.length == 0 ) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
