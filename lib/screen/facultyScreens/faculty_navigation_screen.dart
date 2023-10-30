import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:attendance2/screen/facultyScreens/facultyNavigationScreens/faculty_take_atendance.dart';
import 'package:attendance2/screen/facultyScreens/facultyNavigationScreens/faculty_update_attendance.dart';
import 'package:flutter/material.dart';

class FacultyNavigationScreen extends StatefulWidget {
  const FacultyNavigationScreen({super.key});

  @override
  State<FacultyNavigationScreen> createState() =>
      _FacultyNavigationScreenState();
}

class _FacultyNavigationScreenState extends State<FacultyNavigationScreen> {
  PageController pageController = PageController();
  var currentPage;
  @override
  void initState() {
    currentPage = 0;
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  void updateCurrentPage(int value) {
    setState(() {
      currentPage = value;
    });
    pageController.jumpToPage(value);
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 400), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          indicatorColor: lightNavigationbar,
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            updateCurrentPage(value);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.menu_book_sharp),
              label: "Take Attendance",
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_sharp),
              label: "Update Attendance",
            ),
          ]),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          updateCurrentPage(value);
        },
        children: [FacultyTakeAttendance(), FacultyUpdateAttendance()],
      ),
    );
  }
}
