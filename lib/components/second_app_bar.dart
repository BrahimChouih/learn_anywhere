import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/utils/utils.dart';

class SecondAppBar extends StatelessWidget {
  final Widget title;
  final Widget trailing;

  SecondAppBar({Key key, this.title, this.trailing});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: trailing ??
                SizedBox(
                  width: width * 0.1,
                ),
          ),
        ],
      ),
    );
  }
}
