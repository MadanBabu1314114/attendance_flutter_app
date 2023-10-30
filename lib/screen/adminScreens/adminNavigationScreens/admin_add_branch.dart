import 'package:attendance2/data/data.dart';
import 'package:attendance2/firebase/admin%20backend/admin_add_branch_backend.dart';
import 'package:attendance2/screen/adminScreens/adminNavigationScreens/add_branches.dart';
import 'package:attendance2/screen/adminScreens/admin_add_branch_and_faculty.dart';
import 'package:attendance2/screen/adminScreens/admin_add_faculty.dart';
import 'package:attendance2/screen/adminScreens/admin_faculty_list_view.dart';
import 'package:attendance2/widget/branch_card.dart';
import 'package:flutter/material.dart';

import '../../../backend/login_with_email_and_password.dart';
import '../../loginAndRegisterScreen/login_for_student_teacher.dart';

class AdminAddBranch extends StatefulWidget {
  const AdminAddBranch({super.key});

  @override
  State<AdminAddBranch> createState() => _AdminAddBranchState();
}

class _AdminAddBranchState extends State<AdminAddBranch>
    with SingleTickerProviderStateMixin {
  List<Branch> listOfBranches = [];
  Widget? currentScreen;
  var isBranchesPresent = false;
  final keyForRefreshIndicator = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    takeBranchesFromFirebase();
    super.initState();
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
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 400),
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(Icons.add_business_sharp),
          title: const Text("Add Branch"),
          bottom: const TabBar(
              tabs: [Text("Current Branches"), Text("View Faculty")]),
          actions: [
            TextButton(
                onPressed: () {
                  firebaseAuth.signOut();
                  showSnackbarScreen(context, "Successfully Log Out");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false);
                },
                child: const Text("Sign Out")),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AdminAddBranchAndFaculty(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              strokeWidth: 2,
              key: keyForRefreshIndicator,
              child: Container(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (isBranchesPresent)
                      ...listOfBranches.map((e) =>
                          BranchCard(branchName: e.name, branchRegulation: ""))
                  ],
                ),
              )),
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
            ),
             const AdminFacultyLstView()
          ],
        ),
      ),
    );
  }
}
