import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  Color? color;
  final VoidCallback onTap;
  MyButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primarycolor,
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: color)),
          )),
    );
  }
}
