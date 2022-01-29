import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  primarySwatch: MaterialColor(0xff0098AF, {
    50: Color(0xff0098AF).withOpacity(.1),
    100: Color(0xff0098AF).withOpacity(.2),
    200: Color(0xff0098AF).withOpacity(.3),
    300: Color(0xff0098AF).withOpacity(.4),
    400: Color(0xff0098AF).withOpacity(.5),
    500: Color(0xff0098AF).withOpacity(.6),
    600: Color(0xff0098AF).withOpacity(.7),
    700: Color(0xff0098AF).withOpacity(.8),
    800: Color(0xff0098AF).withOpacity(.9),
    900: Color(0xff0098AF).withOpacity(.1),
  }),
  primaryColor: Color(0xff0098AF),
  accentColor: Color(0xff00FFDC),
  iconTheme: IconThemeData(
    color: Color(0xff606060),
  ),
  textSelectionHandleColor: Color(0xff434343),
  textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        headline5: TextStyle(
          // color: Colors.black54,
          // color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        subtitle1: TextStyle(
          // color: Colors.black38,
          // color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        button: TextStyle(
          // color: Colors.grey,
          // color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        bodyText2: TextStyle(
          // color: Colors.grey,
          // color: Colors.black54,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodyText1: TextStyle(
          // color: Colors.grey,
          // color: Colors.black54,
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
        headline4: TextStyle(
          // color: Colors.grey,
          // color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        headline3: TextStyle(
          // color: Colors.grey,
          // color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
  // bottomAppBarColor: Colors.transparent,
);

const TextStyle bCourseTitleStyle = TextStyle(
  color: Colors.white,
);
const TextStyle bCourseOwnerStyle = TextStyle(
  color: Color(0xffDBDBDB),
);
const TextStyle bUserNameStyle = TextStyle(
  fontSize: 20,
);

const TextStyle bTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Color(0xff606060),
);
const TextStyle bTitleStyle = TextStyle(
  fontSize: 21,
);
