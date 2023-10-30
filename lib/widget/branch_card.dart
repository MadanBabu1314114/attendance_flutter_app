import 'package:attendance2/colors%20data/colors_data.dart';
import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.branchName,
    required this.branchRegulation,
  });
  final String branchName;
  final String branchRegulation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      elevation: 4,
      color: buttonColor.withOpacity(0.8),
      surfaceTintColor: buttonColor.withOpacity(0.8),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                branchName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                branchRegulation,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
