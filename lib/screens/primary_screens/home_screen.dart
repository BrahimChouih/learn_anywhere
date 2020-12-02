import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/controllers/controllers.dart';
import 'package:learn_anywhere/models/course.dart';

class HomeScreen extends StatelessWidget {
  final CourseController courseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<CourseController>(
        builder: (_) {
          return coursesListView();
        },
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
        courseController.scrollController.jumpTo(courseController.lastOffset);
      } catch (e) {}
    });

    // save current postion
    courseController.scrollController.addListener(() {
      courseController.lastOffset = courseController.scrollController.offset;
    });

    if (courseController.courses.length != 0) {
      return RefreshIndicator(
        onRefresh: () async {
          courseController.initCourses();
        },
        child: ListView.builder(
          controller: courseController.scrollController,
          itemCount: courseController.courses.length,
          itemBuilder: (_, i) {
            Course course = courseController.courses[i];
            return CourseItem(course: course);
          },
        ),
      );
    } else {
      return Center(
        child: Text("- There is not any course !!\n- Please add a course."),
      );
    }
  }
}
