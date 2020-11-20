import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/screens/auth_screens/sign_in_up.dart';
import 'package:learn_anywhere/screens/primary_screens/primary_screen.dart';

class SplashScreen extends StatefulWidget {
  static const idSplashScreen = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToScreen() async {
    await AuthMethods.getTokenFromSP();
    if (AuthMethods.apiToken == null) {
      Get.offAndToNamed(SignInUpScreen.idSignIn);
    } else {
      Get.offAndToNamed(PrimaryScreen.idPrimaryScreen);
    }
  }

  @override
  void initState() {
    goToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(Icons.home),
      ),
    );
  }
}
