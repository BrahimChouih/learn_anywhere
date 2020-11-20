import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/screens/primary_screens/home_screen.dart';

class BottomNavigationBarController extends GetxController {
  Widget widget = HomeScreen();
  int currentIndex = 0;

  void onTap({Widget widget, int newIndex}) {
    this.widget = widget;
    this.currentIndex = newIndex;
    update();
  }
}
