import 'package:flutter/material.dart';
import 'package:get/get.dart';

const TextStyle bTitleStyle = TextStyle(
  fontSize: 21,
);
LinearGradient gradient = new LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Get.theme.accentColor,
    Get.theme.primaryColor,
  ],
);
