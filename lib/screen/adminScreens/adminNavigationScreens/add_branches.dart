import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:attendance2/screen/adminScreens/admin_navigation_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../backend/excel_operation/excel.dart';
import '../../../firebase/admin backend/admin_add_branch_backend.dart';

class Student {
  final String name;
  final String roll_number;
  final String section_id;
  final String year;
  final String branch_id;
  final String phone_number1;
  final String phone_number2;

  Student(
    this.name,
    this.roll_number,
    this.section_id,
    this.year,
    this.branch_id,
    this.phone_number1,
    this.phone_number2,
  );
}

class AddBranches extends StatefulWidget {
  const AddBranches({super.key});

  @override
  State<AddBranches> createState() => _AddBranchesState();
}

class _AddBranchesState extends State<AddBranches> {
   

  String _filePath = '';
  FilePickerResult? resultPicker;
  List<dynamic>? listOfStudents;
  var isUploading = false;

  void showSnackbarScreen(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          message,
          style: const TextStyle(fontSize: 25),
        ),
        actions: [
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => const AdminNavigationScreen()));
            },
            icon: const Icon(Icons.emoji_nature_outlined),
            label: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
        resultPicker = result;
      });
    }
    await readExcel(_filePath).then((value) {
      setState(() {
        listOfStudents = value;
      });
    });
  }

  void enterDataIntoFirebase() async {
    setState(() {
      isUploading = true;
    });
    for (var student in listOfStudents!) {
      // await addBranchYearSectionFromExcel(Student(student[1], student[0],
      //     "Section-A", student[3], student[2], student[4] ,student[5]));
      if (student.length == 6) {
        var temp = [];

        temp.addAll([
          student[0],
          student[1],
          student[2],
          student[3],
          student[4],
          student[5],
          student[5],
        ]);
        student.clear();
        for (var e in temp) {
          student.add(e);
        }
      }
      await addBranchYearSectionFromExcel(
        Student(
          student[1],
          student[0],
          student[2],
          student[4],
          student[3],
          student[5],
          student[6],
        ),
      );
    }
    setState(() {
      isUploading = false;
    });
    showSnackbarScreen("Data update successful");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Attendance"),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                database.remove();
              },
              child: const Text("Clear database"),
            )
          ],
        ),
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Card(
                      surfaceTintColor: Colors.white,
                      child: Column(
                        children: [
                          Card(
                            color: CardColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Note:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.red),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              "Excel sheet must be in the below formate",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Roll Number | Names | Section | Branch | Year | Phone Number1 | Phone Number2",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextButton(
                            onPressed: () {
                              pickFile();
                            },
                            child: _filePath.isEmpty
                                ? const Text("Add AddBranches file")
                                : Text(resultPicker!.names.first.toString()),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        enterDataIntoFirebase();
                      },
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text("Enter"),
                      style: ElevatedButton.styleFrom(
                        textStyle:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              if (isUploading) CircularProgressIndicator()
            ],
          ),
        ));
  }
}
