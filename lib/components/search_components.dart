import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/controllers/controllers.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';

import 'home_components.dart';

class SearchField extends StatelessWidget {
  SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Type the name of a course or its owner !!!',
          prefixIcon: Icon(Icons.youtube_searched_for),
        ),
        controller: searchController.statementController,
        onChanged: (statement) {
          searchController.searchFun();
        },
      ),
    );
  }
}

class SearchResultItem extends StatelessWidget {
  final Course course;
  SearchResultItem({this.course});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      padding: EdgeInsets.only(right: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(4, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height * 0.2,
              margin: EdgeInsets.only(right: width * 0.02),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: course.cover,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title.toUpperCase(),
                style: bCourseTitleStyle,
              ),
              Text(
                course.owner.userName.toUpperCase(),
                style: bCourseOwnerStyle,
              ),
              RateStars(
                rate: course.rate,
                numReviewers: course.numReviewers,
              ),
              Text(
                course.price.toString() + ' \$',
                style: bCourseOwnerStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
