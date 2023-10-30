 
import 'package:flutter/material.dart';

import '../colors data/colors_data.dart';
import '../screen/adminScreens/adminNavigationScreens/add_branches.dart';

// ignore: must_be_immutable
class StudentAttendanceUpdateCard extends StatefulWidget {
  StudentAttendanceUpdateCard(
      {super.key,
      required this.student,
      required this.studentAbsentList,
      required this.studentIsPresent});
  Student student;
  bool studentIsPresent;
  List studentAbsentList;

  @override
  State<StudentAttendanceUpdateCard> createState() => _StudentAttendanceUpdateCardState();
}

class _StudentAttendanceUpdateCardState extends State<StudentAttendanceUpdateCard> {
  void updateStudentAbentList() {
    if (widget.studentIsPresent) {
      if (widget.studentAbsentList.contains(widget.student)) {
        widget.studentAbsentList.remove(widget.student);
      }
    } else {
      widget.studentAbsentList.add(widget.student);
    }
  }

  @override
  void initState() {
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.studentIsPresent = !widget.studentIsPresent;
        });
        updateStudentAbentList();
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 4,
        color: widget.studentIsPresent ? buttonColor : CardColor,
        surfaceTintColor: widget.studentIsPresent ? buttonColor : CardColor,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.student.roll_number,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
              Text(
                widget.student.name,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
