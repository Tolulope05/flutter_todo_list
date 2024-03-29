import 'package:flutter/material.dart';

const Color bluishColor = Color(0xff32A6DE);
const Color yellowColor = Color(0xffffb746);
const Color pinkColor = Color(0xffff4667);
const Color white = Colors.white;
const Color scaffoldBgColor = Color(0xFFE8FDFD);
const Color darkGreyColor = Color(0xff121212);
const Color headerColor = Color(0xff424242);
const Color greyColor = Color(0xffBDBDBD);
const Color greenColor = Color(0xff4caf50);

const primarycolor = bluishColor;

class Themes {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.lightBlue,
          ),
      scaffoldBackgroundColor: scaffoldBgColor,
      primaryColor: primarycolor,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: Colors.green,
          ), colorScheme: const ColorScheme(background: scaffoldBgColor),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      primaryColor: headerColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkGreyColor,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(), colorScheme: const ColorScheme(background: darkGreyColor),
    );
  }
}
