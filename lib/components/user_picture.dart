import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/models/user.dart';
import 'package:learn_anywhere/themes/size.dart';

class UserPicture extends StatelessWidget {
  UserPicture({this.size, this.picture});
  double size = width * 0.1;
  var picture;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size * 0.5,
      child: picture == null
          ? Container(
              child: Icon(
                Icons.account_circle_outlined,
                color: Get.theme.iconTheme.color,
                size: size,
              ),
            )
          : null,
      backgroundImage: picture != null ? picture : null,
      backgroundColor: Colors.transparent,
    );
  }
}
