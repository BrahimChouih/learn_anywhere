import 'package:flutter/cupertino.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/models/category.dart';
import 'package:learn_anywhere/models/user.dart';

class Course {
  int id;
  String title;
  String description;
  String create_at;
  NetworkImage cover;
  double price;
  double rate;
  int numReviewers;
  Category category;
  User owner;
  int students;
  Course(Map<String, dynamic> map) {
    fromMap(map);
  }
  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.create_at = map['create_at'];
    this.price = map['price'];
    this.rate = map['rate'];
    this.numReviewers = map['numReviewers'];
    this.students = map['students']?.length;

    try {
      if (map['cover'].toString().contains(api)) {
        // cover = image URL
        this.cover = NetworkImage(map['cover']);
      } else {
        // cover = image PATH in server
        this.cover = NetworkImage(api + map['cover']);
      }
    } catch (e) {}

    try {
      this.category = Category(map['category']);
    } catch (e) {}
    try {
      this.owner = User(map['owner']);
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = this.id;
    map['title'] = this.title;
    map['description'] = this.description;
    map['create_at'] = this.create_at;
    map['price'] = this.price;
    map['rate'] = this.rate;
    map['numReviewers'] = this.numReviewers;
    return map;
  }
}
