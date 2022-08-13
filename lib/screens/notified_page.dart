import 'package:flutter/material.dart';
import 'package:flutter_todo_list/const/styles.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? payload;
  const NotifiedPage({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          payload!.split("|")[0],
          style: titleStyle,
        ),
      ),
      body: Center(
        child: Text(payload!.split("|")[1]),
      ),
    );
  }
}
