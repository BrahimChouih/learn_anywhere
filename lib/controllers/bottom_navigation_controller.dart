import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  // Widget widget = HomeScreen();
  int currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  // when tap on item from bottom navigator bar
  void onTap(int newIndex) {
    // pageController.jumpToPage(newIndex);
    print(newIndex);
    pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    update();
  }

  // change state B.N.Bar's items when page view changed
  void onPageChanged(int newIndex) {
    this.currentIndex = newIndex;
    update();
  }
}
