import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/search_components.dart';
import 'package:learn_anywhere/controllers/controllers.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/size.dart';

class PurchasedCoursesScreen extends StatelessWidget {
  final PurchasedCoursesController purchasedCoursesController =
      Get.put(PurchasedCoursesController());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        purchasedCoursesController.initCourses();
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: width * 0.02,
            right: width * 0.02,
            top: height * 0.02,
          ),
          height: height * 0.9,
          child: GetBuilder<PurchasedCoursesController>(
            builder: (_) {
              return coursesListView();
            },
          ),
        ),
      ),
    );
  }

  Widget coursesListView() {
    // wait connecting
    if (purchasedCoursesController.connecting) {
      return Center(child: CircularProgressIndicator());
    }

    // go to last postion
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        scrollController.jumpTo(purchasedCoursesController.lastOffset);
      } catch (e) {}
    });

    // save current postion
    scrollController.addListener(() {
      purchasedCoursesController.lastOffset = scrollController.offset;
    });

    return RefreshIndicator(
      onRefresh: () async {
        purchasedCoursesController.initCourses();
      },
      child: purchasedCoursesController.courses.length != 0
          ? ListView.builder(
              controller: scrollController,
              itemCount: purchasedCoursesController.courses.length,
              itemBuilder: (_, i) {
                Course course = purchasedCoursesController.courses[i];
                return SearchResultItem(
                  course: course,
                  mode: 'purchased',
                );
              },
            )
          : Center(
              child:
                  Text("- There is not any course !!\n- Please add a course."),
            ),
    );
  }
}
