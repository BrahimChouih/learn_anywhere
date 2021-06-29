import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/screens/course/course_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/primary_screen.dart';
import 'package:learn_anywhere/splash_screen.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'screens/auth_screens/sign_in_up.dart';

void main() {
  runApp(MyApp());
}

ThemeData theme;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: primaryTheme,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      initialRoute: SplashScreen.id,

      getPages: [
        GetPage(
          name: SignInUpScreen.idSignIn,
          page: () => SignInUpScreen(AuthMode.SginIn),
        ),
        GetPage(
          name: SignInUpScreen.idSignUp,
          page: () => SignInUpScreen(AuthMode.SginUp),
        ),
        GetPage(
          name: PrimaryScreen.id,
          page: () => PrimaryScreen(),
        ),
        GetPage(
          name: SplashScreen.id,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: CoueseScreen.id,
          page: () => CoueseScreen(),
        ),
      ],
    );
  }
}
