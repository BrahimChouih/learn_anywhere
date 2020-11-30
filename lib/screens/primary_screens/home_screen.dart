import 'package:flutter/material.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/models/course.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: APIMethods.getAllCourses(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                var courses = snapshot.data;

                if (snapshot.data == null) {
                  courses = [];
                }
                print(snapshot.data);

                // List<Course> courses = [];
                // data.forEach((course) {
                //   courses.add(Course(course));
                // });
                // print(courses.length);
                if (courses.length != 0) {
                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (_, i) {
                      Course course = courses[i];
                      return CourseItem(course: course);
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                        "- There is not any course !!\n- Please add a course."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
