import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/demo_lock_screen.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:flutter_todo_list/services/fingerprint_services.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/onboarding_screen.dart';

class IntroducationStatus {
  final _box = GetStorage();
  bool authstate = FingerPrintServices().loadPrintFromBox();

  final _key = "INTRO_SERVICES_DONE";
  saveIntroService(bool IntroDone) => _box.write(_key, IntroDone);
  bool _loadServiceStatusfromBox() => _box.read(_key) ?? false;

  Widget? get getWidgetStatefromBox {
    // _loadServiceStatusfromBox() ? const MyHomePage() : OnBoardingScreen();
    if (_loadServiceStatusfromBox()) {
      if (authstate) {
        return const DemoLockScreen();
      } else {
        return const MyHomePage();
      }
    } else {
      return const OnBoardingScreen();
    }
  }
}
