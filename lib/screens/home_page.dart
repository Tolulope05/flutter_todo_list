import 'package:flutter/material.dart';
import 'package:flutter_todo_list/services/notification_services.dart';
import 'package:flutter_todo_list/services/theme_services.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initalizeNotification();
    notifyHelper.requestIOSPermission();
    super.initState();
  }

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
              NotifyHelper().displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? "Light Mode activated!"
                    : "Dark Mode activated!",
              );
              setState(() {});
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            )),
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
