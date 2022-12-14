import 'package:flutter/material.dart';
import 'package:flutter_todo_list/db/db_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './const/theme.dart';
import './services/theme_services.dart';
import 'services/one_time_intro_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
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
      title: 'TODO',
      theme: Themes.light(context),
      darkTheme: Themes.dark(context),
      themeMode: ThemeServies().theme,
      home: IntroducationStatus().getWidgetStatefromBox,
    );
  }
}
