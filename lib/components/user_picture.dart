import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/themes/size.dart';

class UserPicture extends StatelessWidget {
  UserPicture({this.size});
  double size = width * 0.1;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size * 0.5,
      child: AuthMethods.user.picture.runtimeType.toString() != 'NetworkImage'
          ? Container(
              child: Icon(
                AuthMethods.user.picture,
                color: Get.theme.iconTheme.color,
                size: size,
              ),
            )
          : null,
      backgroundImage:
          AuthMethods.user.picture.runtimeType.toString() == 'NetworkImage'
              ? AuthMethods.user.picture
              : null,
      backgroundColor: Colors.transparent,
    );
  }
}
