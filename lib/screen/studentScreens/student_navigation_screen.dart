import 'package:attendance2/screen/studentScreens/studentNavigationScreens/student_view_month_attendance.dart';
import 'package:attendance2/screen/studentScreens/studentNavigationScreens/student_view_notification.dart';
import 'package:attendance2/screen/studentScreens/studentNavigationScreens/student_view_today_attendance.dart';
import 'package:flutter/material.dart';

import '../../colors data/colors_data.dart';

class StduentNavigationScreen extends StatefulWidget {
  const StduentNavigationScreen({super.key});

  @override
  State<StduentNavigationScreen> createState() =>
      _StduentNavigationScreenState();
}

class _StduentNavigationScreenState extends State<StduentNavigationScreen> {
  var currentPage;

  PageController pageController = PageController();

  @override
  void initState() {
    setState(() {
      currentPage = 0;
    });
    pageController = PageController(initialPage: currentPage, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateCurrentPage(int index) {
      setState(() {
        currentPage = index;
      });
      pageController.jumpToPage(currentPage);
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          indicatorColor: lightNavigationbar,
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            updateCurrentPage(value);
          },
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          height: 50,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(
                Icons.view_headline,
                color: Colors.black,
              ),
              icon: Icon(Icons.app_registration_rounded),
              label: "View Today Attendance",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.article_rounded,
                color: Colors.black,
              ),
              icon: Icon(Icons.article_outlined),
              label: "View Month Attendance",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.black,
              ),
              icon: Icon(Icons.notifications),
              label: "View Notification",
            ),
          ],
        ),
        body: PageView(
          onPageChanged: (value) {
            updateCurrentPage(value);
          },
          controller: pageController,
          children: const [
            StudentViewTodayAttendance(),
            StudentviewMonthAttendance(),
            StudentViewNotification()
          ],
        ));
  }
}
