import 'package:attendance2/firebase/faculty%20backend/faculty_take_attendance_backend.dart';
import 'package:flutter/material.dart';
import '../../../colors data/colors_data.dart';
import '../Faculty Attendance/faculty_update_attendance_for_students.dart';

class FacultyUpdateAttendance extends StatefulWidget {
  const FacultyUpdateAttendance({super.key});

  @override
  State<FacultyUpdateAttendance> createState() =>
      _FacultyUpdateAttendanceState();
}

class _FacultyUpdateAttendanceState extends State<FacultyUpdateAttendance> {
  var selectedBranch;
  var selectedSection;
  var selectedYear;
  var selectedSubject;
  var period;
  var selectedDate;
  List listOfBranches = [];
  List listOfyears = [];
  List listOfSections = [];
  List listOfSubject = [
    "Communicative English",
    "Mathematics – I",
    "Applied Chemistry",
    "Programming for Problem Solving using C",
    "Computer Engineering Workshop",
    "English Communication Skills Laboratory",
    "Applied Chemistry Lab",
    "Programming for Problem Solving using C Lab",
    "Mathematics – II",
    "Applied Physics",
    "Digital Logic Design",
    "Python Programming",
    "Data Structures",
    "Applied Physics Lab",
    "Python Programming Lab",
    "Data Structures Lab",
    "Mathematics III",
    "Mathematical Foundations of Computer Science",
    "Fundamentals of Data Science",
    "Object Oriented Programming with Java",
    "Database Management Systems",
    "Fundamentals of Data Science Lab",
    "Object Oriented Programming with Java Lab",
    "Database Management Systems Lab",
    "Mobile App Development",
    "Essence of Indian Traditional Knowledge",
    "Probability and Statistics",
    "Computer Organization",
    "Data Warehousing and Mining",
    "Formal Languages and Automata Theory",
    "Managerial Economics and Financial Accountancy",
    "R Programming Lab",
    "Data Mining using Python Lab",
    "Web Application Development Lab",
    "MongoDB",
    "Computer Networks",
    "Big Data Analytics",
    "Design and Analysis of Algorithms",
    "Professional Elective-II",
    "Open Elective-II",
    "Computer Networks Lab",
    "Big Data Analytics Lab",
    "Deep Learning with TensorFlow",
    "Skill Oriented Course - IV",
    "Professional Elective-III",
    "Professional Elective-IV",
    "Professional Elective-V",
    "Open Elective-III",
    "Universal Human Values 2: Understanding Harmony",
    "Major Project Work, Seminar Internship"
  ];
  var str;

  @override
  void initState() {
    takeListOfYears();
    takeListOfBranch();
    takeListOfSection();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.book),
        title: const Text("Faculty Update Attendance"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("WELCOME",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "choose your class",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
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
                            child: Text("Select Subject"),
                          ),
                          value: selectedSubject,
                          items: listOfSubject
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
                              selectedSubject = value.toString();
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
                        child: TextButton.icon(
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    FacultyUpdateAttendanceForStudents(
                                      branch: selectedBranch,
                                      section: selectedSection,
                                      year: selectedYear,
                                      subject: selectedSubject,
                                      period: period,
                                      selectedDate: selectedDate,
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
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (listOfSections.length == 0) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
