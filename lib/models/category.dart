import 'package:flutter/material.dart';

class Category {
  int id;
  String category;
  Image image;

  Category(Map<String, dynamic> map) {
    fromMap(map);
  }

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.category = map['category'];
    this.image = Image.network(map['image']);
  }
}
