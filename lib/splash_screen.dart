import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/screens/auth_screens/sign_in_up.dart';
import 'package:learn_anywhere/screens/primary_screens/primary_screen.dart';
import 'package:learn_anywhere/themes/size.dart';

class SplashScreen extends StatefulWidget {
  static const idSplashScreen = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToScreen() async {
    try {
      await AuthMethods.getTokenFromSP();
      if (AuthMethods.apiToken == null) {
        Get.offAndToNamed(SignInUpScreen.idSignIn);
      } else {
        Get.offAndToNamed(PrimaryScreen.idPrimaryScreen);
      }
    } catch (e) {
      AuthMethods.signOut();
      Get.offAndToNamed(SignInUpScreen.idSignIn);
    }
  }

  @override
  void initState() {
    goToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.isPortrait) {
      height = Get.height;
      width = Get.width;
    } else {
      height = Get.width;
      width = Get.height;
    }

    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
