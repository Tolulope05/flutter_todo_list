import 'package:flutter/material.dart';

const Color bluishColor = Color.fromARGB(255, 92, 102, 204);
const Color yellowColor = Color(0xffffb746);
const Color pinkColor = Color(0xffff4667);
const Color white = Colors.white;
const Color scaffoldBgColor = Color(0xFFE8FDFD);
const Color darkGreyColor = Color(0xff121212);
const Color headerColor = Color(0xff424242);
const Color greyColor = Color(0xffBDBDBD);

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
          ),
      backgroundColor: Colors.lightBlue,
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      primaryColor: headerColor,
      brightness: Brightness.dark,
      backgroundColor: darkGreyColor,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(),
    );
  }
}
