import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/models/user.dart';
import 'package:learn_anywhere/themes/size.dart';

class UserPicture extends StatelessWidget {
  UserPicture({this.size, @required this.user});
  double size = width * 0.1;
  User user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size * 0.5,
      child: user.picture.runtimeType.toString() == "IconData"
          ? Container(
              child: Icon(
                user.picture,
                color: Get.theme.iconTheme.color,
                size: size,
              ),
            )
          : null,
      backgroundImage: user.picture.runtimeType.toString() != "IconData"
          ? user.picture
          : null,
      backgroundColor: Colors.transparent,
    );
  }
}
