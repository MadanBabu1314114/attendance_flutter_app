import 'package:flutter/material.dart';

import '../colors data/colors_data.dart';
import '../screen/adminScreens/adminNavigationScreens/add_branches.dart';

class StudentAttendanceViewCard extends StatelessWidget {
  StudentAttendanceViewCard({
    super.key,
    required this.student,
    required this.studentAbsentList,
  });
  Student student;

  List studentAbsentList;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      elevation: 4,
      color: !studentAbsentList.contains(student) ? buttonColor : CardColor,
      surfaceTintColor:
          !studentAbsentList.contains(student) ? buttonColor : CardColor,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                student.roll_number,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
            Text(
              student.name,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
