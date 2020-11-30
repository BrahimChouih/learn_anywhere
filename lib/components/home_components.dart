import 'package:flutter/material.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';

class RateStars extends StatelessWidget {
  final double rate;
  final int numReviewers;
  List<Widget> rateWidgets = [];
  RateStars({this.rate, this.numReviewers});
  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 5; i++) {
      IconData icon = Icons.star;
      if (rate < i) {
        if (rate < (i - 0.5)) {
          icon = Icons.star_border_outlined;
        } else {
          icon = Icons.star_half;
        }
      }

      rateWidgets.add(Icon(
        icon,
        color: Color(0xffFFA303),
      ));
    }
    String numR = '';
    if (numReviewers >= 1000) {
      double number = numReviewers / 1000;
      numR = '${number.toStringAsFixed(1)}k';
    } else {
      numR = '$numReviewers';
    }

    rateWidgets.add(Text(
      '($numR)',
      style: bCourseOwnerStyle,
    ));
    return Row(
      children: rateWidgets,
    );
  }
}

class CourseItem extends StatelessWidget {
  final Course course;
  CourseItem({this.course});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.35,
      margin: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.03,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: course.cover,
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(4, 6),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: height * 0.18,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.03,
              horizontal: width * 0.05,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black54,
            ),
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
