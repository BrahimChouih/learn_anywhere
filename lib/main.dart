import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/screens/primary_screens/primary_screen.dart';
import 'package:learn_anywhere/splash_screen.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'screens/auth_screens/sign_in_up.dart';

void main() {
  runApp(MyApp());
}

ThemeData theme;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = Get.height;
    width = Get.width;
    return GetMaterialApp(
      theme: primaryTheme,
      initialRoute: SplashScreen.idSplashScreen,
      routes: {
        SignInUpScreen.idSignIn: (context) => SignInUpScreen(AuthMode.SginIn),
        SignInUpScreen.idSignUp: (context) => SignInUpScreen(AuthMode.SginUp),
        PrimaryScreen.idPrimaryScreen: (context) => PrimaryScreen(),
        SplashScreen.idSplashScreen: (context) => SplashScreen(),
      },
    );
  }
}
