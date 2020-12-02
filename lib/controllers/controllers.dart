import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/models/course.dart';

class UserController extends GetxController {}

class CourseController extends GetxController {
  List<Course> courses = [];
  ScrollController scrollController = ScrollController(keepScrollOffset: true);
  bool connecting = false;

  initCourses() async {
    connecting = true;
    update();
    courses = await APIMethods.getAllCourses();
    connecting = false;
    update();
  }
}
