import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

LinearGradient gradient = new LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Get.theme.accentColor,
    Get.theme.primaryColor,
  ],
);

Widget editIcon = Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey.withOpacity(0.3),
  ),
  child: SvgPicture.asset(
    "assets/icons/edit.svg",
  ),
);
