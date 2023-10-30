import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:attendance2/screen/adminScreens/admin_view_students_attendance_table.dart';
import 'package:attendance2/widget/snackbar_custom.dart';
import 'package:flutter/material.dart';

import '../../../colors data/colors_data.dart';
import '../../../firebase/faculty backend/faculty_take_attendance_backend.dart';

class AdminViewAttendance extends StatefulWidget {
  const AdminViewAttendance({super.key});

  @override
  State<AdminViewAttendance> createState() => _AdminViewAttendanceState();
}

class _AdminViewAttendanceState extends State<AdminViewAttendance> {
  List<String> listOfBranches = [];

  List<Student> listOfStudents = [];

  var selectedBranch;

  var selectedSection;

  var selectedYear;

  var selectedSubject;

  List listOfyears = [];

  List listOfSections = [];

  Widget? currentScreen;

  var isBranchesPresent = false;

  final keyForRefreshIndicator = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    takeBranchesFromFirebase();
    takeListOfBranch();
    takeListOfSection();
    takeListOfYears();
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

  void takeBranchesFromFirebase() async {
    await retrieveBranches().then((value) {
      setState(() {
        listOfBranches = value;
      });
    });
    if (listOfBranches.length > 0) {
      isBranchesPresent = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.add_business_sharp),
          title: Text("View Attendance"),
        ),
        body: RefreshIndicator(
          strokeWidth: 2,
          key: keyForRefreshIndicator,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(buttonColor)),
                        onPressed: () {
                          snackBarUser(context, "OK");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  AdminViewStudentsAttendanceTable(
                                    branch: selectedBranch,
                                    section: selectedSection,
                                    year: selectedYear,
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          onRefresh: () async {
            await retrieveBranches().then((value) {
              setState(() {
                listOfBranches = value;
              });
            });
            if (listOfBranches.length > 0) {
              isBranchesPresent = true;
            }
          },
        ));
  }
}
