import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:attendance2/screen/adminScreens/admin_add_faculty.dart';
import 'package:flutter/material.dart';

class AdminAddBranchAndFaculty extends StatefulWidget {
  const AdminAddBranchAndFaculty({super.key});

  @override
  State<AdminAddBranchAndFaculty> createState() =>
      _AdminAddBranchAndFacultyState();
}

class _AdminAddBranchAndFacultyState extends State<AdminAddBranchAndFaculty>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Text("Add Branch"),
              Text('Add Faculty'),
            ],
          ),
        ),
        body: TabBarView(
           
          children: [
            AddBranches(),
            AdminAddFaculty(),
          ],
        ),
      ),
    );
  }
}
