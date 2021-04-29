import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/controllers/app_bar_controller.dart';
import 'package:learn_anywhere/screens/profile_screen/profile_screen.dart';
import 'package:learn_anywhere/themes/size.dart';

class PraimaryAppBar extends StatelessWidget {
  final AppBarController appBarController = Get.put(AppBarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: width * 0.02),
              child: GetBuilder<AppBarController>(
                id: AppBarController.usrPictureID,
                builder: (_) => UserPicture(
                  size: width * 0.09,
                  picture: AuthMethods.user.picture,
                ),
              ),
            ),
            onTap: () {
              // Get.toNamed(ProfileScreen.id);
              Get.to(ProfileScreen(
                user: AuthMethods.user,
                // isMe: false,
              ));
            },
          ),
          Row(
            children: [
              GetBuilder<AppBarController>(
                id: AppBarController.notifID,
                builder: (_) => NotificationShoppingCart(
                  iconData: Icons.notifications_none,
                  onTap: () {
                    appBarController.onChangenotificationsCount();
                  },
                  numState: appBarController.notificationsCount,
                ),
              ),
              GetBuilder<AppBarController>(
                id: AppBarController.shCartID,
                builder: (_) => NotificationShoppingCart(
                  iconData: Icons.shopping_cart_outlined,
                  onTap: () {
                    appBarController.onChangeShoppingCartCount();
                  },
                  numState: appBarController.shoppingCartCount,
                ),
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
  int numState;
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
              numState < 10 ? '$numState' : '+9',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
