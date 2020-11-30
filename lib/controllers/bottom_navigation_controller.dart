import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/screens/primary_screens/home_screen.dart';

class BottomNavigationBarController extends GetxController {
  // Widget widget = HomeScreen();
  int currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void onTap(int newIndex) {
    this.currentIndex = newIndex;
    // pageController.jumpToPage(newIndex);
    pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    update();
  }
}
