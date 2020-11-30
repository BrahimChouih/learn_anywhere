import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData.light().copyWith(
  primaryColor: Color(0xff0098AF),
  accentColor: Color(0xff00FFDC),
  iconTheme: IconThemeData(
    color: Color(0xff606060),
  ),
  textSelectionHandleColor: Color(0xff434343),
  // bottomAppBarColor: Colors.transparent,
);

const TextStyle bCourseTitleStyle = TextStyle(
  color: Colors.white,
);
const TextStyle bCourseOwnerStyle = TextStyle(
  color: Color(0xffDBDBDB),
);
