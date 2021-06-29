import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/components/comment_item.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/components/second_app_bar.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/controllers/app_bar_controller.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/models/reviewer.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';

class CommentsScreen extends StatefulWidget {
  CommentsScreen({Key key, this.course, this.isPurchased}) : super(key: key);

  Course course;
  bool isPurchased = false;

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final appBarController = Get.find<AppBarController>();

  RxBool isLoading;

  List<Reviewer> reviewers;

  void getReviewer() async {
    isLoading.value = true;
    reviewers = await APIMethods.getReviewersOnCourse(widget.course.id);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    // getReviewer();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(
              title: Text("Course"),
              trailing: !widget.isPurchased
                  ? IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        appBarController.onChangeShoppingCartCount();
                      },
                    )
                  : null,
            ),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<List<Reviewer>>(
                    future: APIMethods.getReviewersOnCourse(widget.course.id),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      if (snapshot.data.isEmpty) return Container();

                      List<Reviewer> reviewers = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: reviewers.length,
                          itemBuilder: (_, i) => CommentItem(
                            reviewer: reviewers[i],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.isPurchased
          ? FloatingActionButton(
              child: Icon(Icons.rate_review_outlined),
              backgroundColor: Get.theme.primaryColor,
              onPressed: () async {
                Map result = await Get.dialog<Map>(
                  WriteAComment(course: widget.course),
                );
                if (result != null && result['submit']) {
                  print(result['reviewer'].toJson());
                  try {
                    await APIMethods.addReviewOnCourse(result['reviewer']);
                  } catch (e) {
                    Get.defaultDialog(
                      title: 'Waite',
                      content: Text(
                        (e as DioError).response.data['response'].toString(),
                      ),
                      confirm: TextButton(
                        onPressed: () => Get.back(),
                        child: Text('OK'),
                      ),
                    );
                  }
                  setState(() {});
                }
              },
            )
          : null,
    );
  }
}
