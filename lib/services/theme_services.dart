import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServies {
  final _box = GetStorage();
  final _key = "IS_DARK_MODE";

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemefromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemefromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchtheme() {
    Get.changeThemeMode(_loadThemefromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemefromBox());
  }
}
