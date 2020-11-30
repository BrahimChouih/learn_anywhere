import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/themes/size.dart';

class PraimaryAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: width * 0.02),
            child: CircleAvatar(
              child: AuthMethods.user.picture.runtimeType == Icon
                  ? AuthMethods.user.picture
                  : null,
              backgroundImage:
                  AuthMethods.user.picture.runtimeType.toString() ==
                          'NetworkImage'
                      ? AuthMethods.user.picture
                      : null,
              backgroundColor: Colors.transparent,
            ),
          ),
          Row(
            children: [
              NotificationShoppingCart(
                iconData: Icons.notifications_none,
                onTap: () {},
                numState: '2',
              ),
              NotificationShoppingCart(
                iconData: Icons.shopping_cart_outlined,
                onTap: () {},
                numState: '+9',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationShoppingCart extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  String numState;
  NotificationShoppingCart({this.iconData, this.onTap, this.numState});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          IconButton(
            icon: Icon(iconData),
            color: Get.theme.iconTheme.color,
            iconSize: width * 0.09,
            onPressed: onTap,
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: width * 0.025,
            child: Text(
              '$numState',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
