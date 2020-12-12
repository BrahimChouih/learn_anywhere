import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/models/course.dart';

class UserController extends GetxController {}

class CourseController extends GetxController {
  List<Course> courses = [];
  double lastOffset = 0.0;
  bool connecting = false;

  initCourses() async {
    connecting = true;
    update();
    courses = await APIMethods.getAllCourses();
    connecting = false;
    update();
  }
}

class SearchController extends CourseController {
  SearchController() {
    initCourses();
  }

  List<Course> lastCourses = [];

  TextEditingController statementController = TextEditingController();

  searchFun() async {
    if (lastCourses.length < courses.length) {
      lastCourses = courses;
    }
    String searchStatement = statementController.text.toLowerCase();
    if (searchStatement.isNotEmpty && !searchStatement.isNull) {
      courses = [];
    } else {
      this.initCourses();
    }
    lastCourses.forEach((course) {
      bool isFinded = course.title.toLowerCase().contains(searchStatement) ||
          course.owner.userName.toLowerCase().contains(searchStatement);
      print(isFinded);
      if (isFinded) {
        courses.add(course);
      }
    });
    this.lastOffset = 0.0;
    update();
  }
}

class PurchasedCoursesController extends CourseController {
  PurchasedCoursesController() {
    initCourses();
  }
  @override
  initCourses() async {
    connecting = true;
    update();
    await AuthMethods.refreshUserInfo();
    courses = AuthMethods.user.purchasedCourses;
    connecting = false;
    update();
  }
}
