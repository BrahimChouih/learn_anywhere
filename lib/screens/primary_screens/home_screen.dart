import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/controllers/controllers.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/size.dart';

class HomeScreen extends StatelessWidget {
  final CourseController courseController = Get.find();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        courseController.initCourses();
      },
      child: SingleChildScrollView(
        child: Container(
          height: height * 0.9,
          child: GetBuilder<CourseController>(
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
    if (courseController.connecting) {
      return Center(child: CircularProgressIndicator());
    }

    // go to last postion
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        scrollController.jumpTo(courseController.lastOffset);
      } catch (e) {}
    });

    // save current postion
    scrollController.addListener(() {
      courseController.lastOffset = scrollController.offset;
    });

    return RefreshIndicator(
      onRefresh: () async {
        courseController.initCourses();
      },
      child: courseController.courses.length != 0
          ? ListView.builder(
              controller: scrollController,
              itemCount: courseController.courses.length,
              itemBuilder: (_, i) {
                Course course = courseController.courses[i];
                return CourseItem(course: course);
              },
            )
          : Center(
              child:
                  Text("- There is not any course !!\n- Please add a course."),
            ),
    );
  }
}
