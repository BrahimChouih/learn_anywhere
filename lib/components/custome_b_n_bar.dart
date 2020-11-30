import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/controllers/bottom_navigation_controller.dart';
import 'package:learn_anywhere/screens/primary_screens/home_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/more_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/purchased_courses_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/search_screen.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/themes/utils.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final BottomNavigationBarController bNBController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomBottomNavigationBarItem(
            iconData: Icons.home,
            index: 0,
            onPressed: () {
              bNBController.onTap(0);
            },
          ),
          CustomBottomNavigationBarItem(
            iconData: Icons.youtube_searched_for,
            index: 1,
            onPressed: () {
              bNBController.onTap(1);
            },
          ),
          SizedBox(width: width * 0.1),
          CustomBottomNavigationBarItem(
            iconData: Icons.verified,
            index: 2,
            onPressed: () {
              bNBController.onTap(2);
            },
          ),
          CustomBottomNavigationBarItem(
            iconData: Icons.menu,
            index: 3,
            onPressed: () {
              bNBController.onTap(3);
            },
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final int index;

  CustomBottomNavigationBarItem({
    this.iconData,
    this.onPressed,
    this.index,
  });
  final BottomNavigationBarController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<BottomNavigationBarController>(
        builder: (_) {
          return IconButton(
            icon: Icon(iconData),
            color: controller.currentIndex == index
                ? Colors.white
                : Get.theme.iconTheme.color,
            iconSize: width * 0.07,
            onPressed: onPressed,
          );
        },
      ),
    );
  }
}
