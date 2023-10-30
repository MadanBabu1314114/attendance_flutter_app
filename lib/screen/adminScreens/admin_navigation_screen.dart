import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/admin_add_notification.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/admin_view_attendance.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/admin_add_branch.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/admin_send_sms.dart';
import 'package:flutter/material.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({super.key});

  @override
  State<AdminNavigationScreen> createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
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
                Icons.add_business_outlined,
                color: Colors.black,
              ),
              icon: Icon(Icons.add_business_sharp),
              label: "Add Branch",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.view_headline,
                color: Colors.black,
              ),
              icon: Icon(Icons.view_headline),
              label: "View Attendance",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              icon: Icon(Icons.notifications),
              label: "Send Notification",
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              icon: Icon(Icons.message),
              label: "Send SMS",
            ),
          ],
        ),
        body: PageView(
          onPageChanged: (value) {
            updateCurrentPage(value);
          },
          controller: pageController,
          children: const [
            AdminAddBranch(),
            AdminViewAttendance(),
            AdminSendNotification(),
            AdminSendSms()
          ],
        ));
  }
}
