import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/components/search_components.dart';
import 'package:learn_anywhere/controllers/controllers.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/size.dart';

class SearchScreen extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: width * 0.02,
        right: width * 0.02,
        top: height * 0.02,
      ),
      child: GetBuilder<SearchController>(
        builder: (_) {
          return Column(
            children: [
              SearchField(),
              SizedBox(height: height * 0.02),
              Expanded(child: coursesListView()),
            ],
          );
        },
      ),
    );
  }

  Widget coursesListView() {
    // go to last postion
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        scrollController.jumpTo(searchController.lastOffset);
      } catch (e) {}
    });

    // save current postion
    scrollController.addListener(() {
      searchController.lastOffset = scrollController.offset;
    });

    if (searchController.courses.length != 0) {
      return ListView.builder(
        controller: scrollController,
        itemCount: searchController.courses.length,
        itemBuilder: (_, i) {
          Course course = searchController.courses[i];
          return SearchResultItem(course: course);
        },
      );
    } else {
      return Center(
        child: Text("- There is not any result."),
      );
    }
  }
}
