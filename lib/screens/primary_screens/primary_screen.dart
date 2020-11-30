import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/app_bars.dart';
import 'package:learn_anywhere/components/custome_b_n_bar.dart';
import 'package:learn_anywhere/controllers/bottom_navigation_controller.dart';
import 'package:learn_anywhere/screens/primary_screens/more_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/purchased_courses_screen.dart';
import 'package:learn_anywhere/screens/primary_screens/search_screen.dart';
import 'package:learn_anywhere/themes/size.dart';

import 'home_screen.dart';

class PrimaryScreen extends StatelessWidget {
  final BottomNavigationBarController bNBController =
      Get.put(BottomNavigationBarController());
  static const idPrimaryScreen = 'primaryScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            PraimaryAppBar(),
            Expanded(
              child: GetBuilder<BottomNavigationBarController>(
                builder: (_) {
                  return PageView(
                    controller: bNBController.pageController,
                    children: [
                      HomeScreen(),
                      SearchScreen(),
                      PurchasedCoursesScreen(),
                      MoreScreen(),
                    ],
                    onPageChanged: bNBController.onTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: width * 0.02,
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircularNotchedRectangle(),
        child: CustomBottomNavigationBar(),
      ),
    );
  }
}
