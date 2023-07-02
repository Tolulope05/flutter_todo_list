import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:get/get.dart';

import '../const/styles.dart';
import '../services/screenLock_services.dart';

class DemoLockScreen extends StatefulWidget {
  const DemoLockScreen({Key? key}) : super(key: key);

  @override
  State<DemoLockScreen> createState() => _DemoLockScreenState();
}

class _DemoLockScreenState extends State<DemoLockScreen> {
  @override
  void initState() {
    ScreenLock(ctx: context).authenticateUser(path: "splash").then((value) {
      if (value == true) {
        Get.to(
          const MyHomePage(),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Please press the button below to show your tasks",
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
                  Icons.fingerprint,
                  size: 32,
                ),
                onPressed: () {
                  ScreenLock(ctx: context).authenticateUser(path: "splash");
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
