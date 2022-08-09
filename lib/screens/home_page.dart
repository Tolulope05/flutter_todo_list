import 'package:flutter/material.dart';
import 'package:flutter_todo_list/services/theme_services.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Get.isDarkMode
              //     ? Get.changeTheme(Themes.light(context))
              //     : Get.changeTheme(Themes.dark(context));
              ThemeServies().switchtheme();
            },
            icon: const Icon(Icons.nightlight_round)),
        title: const Text("TODO LIST"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Icon(
              Icons.art_track,
              size: 60,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
