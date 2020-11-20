import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/size.dart';

class User {
  int id;
  String email;
  String userName;
  String country;
  var picture;
  List<dynamic> purchasedCourses = [];

  User(Map<String, dynamic> map) {
    fromMap(map);
  }

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.userName = map['userName'];
    this.country = map['country'];

    try {
      this.picture = NetworkImage(api + map['picture']);
    } catch (e) {
      this.picture = Icon(
        Icons.account_circle_outlined,
        color: Get.theme.iconTheme.color,
        size: width * 0.11,
      );
    }

    map['purchased_courses'].forEach((e) {
      this.purchasedCourses.add(Course(e));
    });
  }
}
