import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/search_components.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/utils/countries.dart';

class EditUserNameDialog extends StatelessWidget {
  TextEditingController controller;
  Function onConfirm;
  EditUserNameDialog({this.controller, this.onConfirm});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            autofocus: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  onConfirm();
                  Get.back();
                },
                child: Text('Ok'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDownCountriesMenu extends StatelessWidget {
  final Function onChange;
  final String value;

  const DropDownCountriesMenu({Key key, this.onChange, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: width * 0.05),
      Text("From : "),
      SizedBox(width: width * 0.05),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: DropdownButton(
          value: this.value,
          underline: Container(),
          onChanged: onChange,
          items: <DropdownMenuItem>[
            for (int i = 0; i < countries.length; i++)
              DropdownMenuItem(
                child: Text(countries[i]),
                value: countries[i],
              ),
          ],
        ),
      ),
    ]);
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        Text("Email : "),
        SizedBox(width: width * 0.05),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.1),
      ],
    );
  }
}

class CoursesMadeByUserView extends StatelessWidget {
  final List<Course> courses;
  final int length;
  const CoursesMadeByUserView({
    Key key,
    this.courses,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return length != 0
        ? ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (_, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.05,
              ),
              child: SearchResultItem(
                course: courses[index],
              ),
            ),
          )
        : Center(
            child: Text('No courses'),
          );
  }
}
