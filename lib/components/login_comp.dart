import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/utils/utils.dart';

class EmailPasswordField extends StatelessWidget {
  String hintText;
  final TextEditingController controller;
  EmailPasswordField({this.hintText, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: height * 0.02,
        start: width * 0.01,
        end: width * 0.01,
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: hintText == 'Email' ? TextInputType.emailAddress : null,
        obscureText: hintText == 'Password',
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  String lable;
  Function onTap;
  SubmitButton({this.lable, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(top: height * 0.05),
        width: width * 0.5,
        height: height * 0.06,
        child: Center(child: Text(lable)),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
