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
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
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
          "MY TODO",
          style: titleStyle,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        // height: 400,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Get.isDarkMode ? Colors.black38 : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              payload!.split("|")[0],
              style: titleStyle,
            ),
            const SizedBox(height: 20),
            Text(payload!.split("|")[1]),
          ],
        ),
      ),
    );
  }
}
