import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/themes/size.dart';

class ButtonCustomize extends StatelessWidget {
  ButtonCustomize({this.onPressed, this.lable});

  final Function onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.015),
        height: height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: Get.theme.shadowColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(lable),
        ),
      ),
    );
  }
}
