import 'package:flutter/material.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/more_screen_components.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/themes/size.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: UserPicture(size: width * 0.5),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Divider(color: Colors.black),
                ),
                Text('More'),
                Expanded(
                  flex: 1,
                  child: Divider(color: Colors.black),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ButtonCustomize(
                lable: 'Settings',
                onPressed: () {},
              ),
              ButtonCustomize(
                lable: 'About us',
                onPressed: () {},
              ),
              ButtonCustomize(
                lable: 'Sign Out',
                onPressed: () {
                  AuthMethods.signOut();
                },
              ),
            ],
          ),
          SizedBox(height: height * 0.15),
        ],
      ),
    );
  }
}
