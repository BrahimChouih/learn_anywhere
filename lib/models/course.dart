import 'package:flutter/cupertino.dart';
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
    this.category = Category(map['category']);
    this.owner = User(map['owner']);
    this.students = map['students'].length;
    this.cover = NetworkImage(map['cover']);

    print(rate);
  }
}
