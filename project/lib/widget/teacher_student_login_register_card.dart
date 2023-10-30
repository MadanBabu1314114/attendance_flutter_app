import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.imageAsset,
    required this.head,
    required this.value,
    required this.updateValue,
    required this.color,
  });

  final Color color;
  final String imageAsset;
  final String head;
  final bool value;
  final Function(bool) updateValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateValue(!value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: ShapeDecoration(
          color: Color.fromARGB(231, 236, 222, 222).withOpacity(0.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              side: BorderSide(color: color)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imageAsset,
              width: 150,
              height: 150,
            ),
            Text(head  , style: TextStyle(color: Colors.black45),)
          ],
        ),
      ),
    );
  }
}
