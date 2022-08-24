import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/onboarding_screen.dart';

class IntroducationStatus {
  final _box = GetStorage();
  final _key = "INTRO_SERVICES_DONE";
  saveIntroService(bool IntroDone) => _box.write(_key, IntroDone);
  bool _loadServiceStatusfromBox() => _box.read(_key) ?? false;
  Widget? get getWidgetStatefromBox => _loadServiceStatusfromBox()
      ? const MyHomePage()
      : const OnBoardingScreen();
}
