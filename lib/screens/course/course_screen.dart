import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/components/second_app_bar.dart';
import 'package:learn_anywhere/controllers/app_bar_controller.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/screens/course/comments_screen.dart';
import 'package:learn_anywhere/themes/size.dart';

class CoueseScreen extends StatelessWidget {
  static const id = 'CoueseScreen';
  Course course;
  bool isPurchased = false;
  final appBarController = Get.find<AppBarController>();

  CoueseScreen({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AuthMethods.user.purchasedCourses
                .indexWhere((course) => this.course.id == course.id) !=
            -1 ||
        AuthMethods.user.userName == course.owner.userName) {
      isPurchased = true;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(
              title: Text("Course"),
              trailing: !isPurchased
                  ? IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        appBarController.onChangeShoppingCartCount();
                      },
                    )
                  : null,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CourseItem(course: course),
                    // Image.network(course.cover.url),
                    Container(
                      width: width,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Description',
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(course.description),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.rate_review),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {
          Get.to(
            CommentsScreen(
              course: course,
              isPurchased: isPurchased,
            ),
          );
        },
      ),
    );
  }
}
