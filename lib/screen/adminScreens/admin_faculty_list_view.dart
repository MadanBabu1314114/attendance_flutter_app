import 'package:attendance2/firebase/admin%20backend/admin_add_branch_backend.dart';
import 'package:attendance2/widget/branch_card.dart';
import 'package:flutter/material.dart';

class AdminFacultyLstView extends StatefulWidget {
  const AdminFacultyLstView({super.key});

  @override
  State<AdminFacultyLstView> createState() => _AdminFacultyLstViewState();
}

class _AdminFacultyLstViewState extends State<AdminFacultyLstView> {
  List<Faculty> listOfFaculty = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: retrieveFacultyFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listOfFaculty = snapshot.data!;
          return Container(
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                ...listOfFaculty.map((e) =>  SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.username , style: Theme.of(context).textTheme.titleLarge,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(e.email , style: Theme.of(context).textTheme.labelMedium,),
                        )
                      ],
                    ),),
                  ),
                ))
              ],
            ),
          );
        }
        return const Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator()
          ],
        );
      },
    );
  }
}
