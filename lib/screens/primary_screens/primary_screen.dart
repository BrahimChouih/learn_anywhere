import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/app_bars.dart';
import 'package:learn_anywhere/components/custome_b_n_bar.dart';
import 'package:learn_anywhere/controllers/bottom_navigation_controller.dart';

class PrimaryScreen extends StatelessWidget {
  final BottomNavigationBarController bNBController =
      Get.put(BottomNavigationBarController());
  static const idPrimaryScreen = 'primaryScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PraimaryAppBar(),
            Expanded(
              child: GetBuilder<BottomNavigationBarController>(
                builder: (_) {
                  return Container(
                      child: Center(
                    child: bNBController.widget,
                  ));
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
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
