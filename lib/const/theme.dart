import 'package:flutter/material.dart';

const Color bluishColor = Color(0xff4e5ae8);
const Color yellowColor = Color(0xffffb746);
const Color pinkColor = Color(0xffff4667);
const Color white = Colors.white;
const Color darkGreyColor = Color(0xff121212);
const Color headerColor = Color(0xff424242);

const primarycolor = bluishColor;

class Themes {
  static ThemeData light(BuildContext context) {
    return ThemeData(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              color: Colors.green,
            ),
        scaffoldBackgroundColor: yellowColor,
        primaryColor: primarycolor,
        brightness: Brightness.light,
        buttonTheme:
            Theme.of(context).buttonTheme.copyWith(buttonColor: Colors.green));
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
        primaryColor: headerColor,
        brightness: Brightness.dark,
        buttonTheme: Theme.of(context).buttonTheme.copyWith());
  }
}
