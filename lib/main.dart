import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/add_task_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './const/theme.dart';
import './screens/home_page.dart';
import './services/theme_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST',
      theme: Themes.light(context),
      darkTheme: Themes.dark(context),
      themeMode: ThemeServies().theme,
      home: const MyHomePage(),
    );
  }
}
