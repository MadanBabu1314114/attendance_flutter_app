import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:attendance2/firebase/admin%20backend/admin_send_sms_backend.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:flutter/material.dart';
import '../../../backend/sms/sms.dart';
import '../../../firebase/faculty backend/faculty_take_attendance_backend.dart';
 

class AdminSendSms extends StatefulWidget {
  const AdminSendSms({super.key});

  @override
  State<AdminSendSms> createState() => _AdminSendSmsState();
}

class _AdminSendSmsState extends State<AdminSendSms> {
  List<String> listOfBranches = [];
  List<Student> listOfStudents = [];
  var selectedBranch;
  var selectedSection;
  var selectedYear;
  var selectedSubject;
  List<Student> twoPeriodAbsentStudentsList = [];

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

  void findTheTwoPeriodsAttendanceStudents() async {
    DateTime dateTime = DateTime.now();
    await findTheTwoPeriodsAttendanceStudentsInFirebase(
      "${dateTime.day}-${dateTime.month}-${dateTime.year}",
      listOfStudents,
    ).then((value) {
      setState(() {
        twoPeriodAbsentStudentsList = value;
      });
    });
  }
 

  void retrieveStudent() async {
    await retrieveStudentFromYearBranchSection(selectedBranch.toString(),
            selectedSection.toString(), selectedYear.toString())
        .then((value) {
      setState(() {
        listOfStudents = value;
      });

      if (listOfStudents.length != 0) {
        findTheTwoPeriodsAttendanceStudents();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.add_business_sharp),
          title: Text("Send SMS"),
          actions: [
            TextButton(
              onPressed: () {
                // final senderId = 'NRIENG';
                // final templateId = '1707163893447333569';
                // final entityId = '1701159913704978177';

                 
                // final message =  "Dear Parent, your ward is ABSENT today without prior notice. If the attendance of your ward is below 75%, your ward will not be promoted to next semester. So please send your ward to the college regularly. Thanks & Regards, HOD- IT&DS (Contact: 8885552793). NRI Institute of Technology.";
                // List<String> numbers = [];
                // for (var i = 0; i < twoPeriodAbsentStudentsList.length; i++) {
                //   numbers.add(twoPeriodAbsentStudentsList[i].phone_number1);
                // }

                // SMSApi.sendSMS(
                //   senderId: senderId,
                //   templateId: templateId,
                //   entityId: entityId,
                //   numbers: numbers,
                //   message: message,
                // ).then((response) {
                //   final success = response['success'];
                //   final message = response['message'];

                //   if (success) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('SMS sent successfully')),
                //     );
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text(message)),
                //     );
                //   }
                // });
              },
              child: Icon(
                Icons.send,
                size: 30,
                color: buttonColor,
              ),
            )
          ],
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
                          retrieveStudent();
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
                    Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...twoPeriodAbsentStudentsList.map((e) => Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.roll_number,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              Text(
                                                e.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            e.phone_number1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
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
