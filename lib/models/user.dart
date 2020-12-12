import 'package:flutter/material.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/models/course.dart';

class User {
  int id;
  String email;
  String userName;
  String country;
  var picture;
  List<Course> purchasedCourses = [];

  User(Map<String, dynamic> map) {
    fromMap(map);
  }

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.userName = map['username'];
    this.country = map['country'];

    try {
      this.picture = NetworkImage(api + map['picture']);
    } catch (e) {
      this.picture = Icons.account_circle_outlined;
    }
    try {
      print(map['purchased_courses']);
      map['purchased_courses'].forEach((e) {
        print(e);
        this.purchasedCourses.add(Course(e));
      });
    } catch (e) {
      print(e);
    }
  }
}
