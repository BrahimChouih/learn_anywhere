import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/home_components.dart';
import 'package:learn_anywhere/components/search_components.dart';
import 'package:learn_anywhere/components/second_app_bar.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/models/user.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/utils/countries.dart';
import 'package:learn_anywhere/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'ProfileScreen';
  final bool isMe;
  User user;

  ProfileScreen({Key key, this.isMe = true, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String myCountry;
  TextEditingController emailController;
  @override
  void initState() {
    if (widget.isMe) {
      widget.user = AuthMethods.user;
    }
    myCountry = widget.user.country;
    emailController = new TextEditingController(
      text: widget.user.email,
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(
              title: Text(
                widget.isMe ? 'My Profile' : 'Profile',
                style: bTextStyle,
              ),
              trailing: widget.isMe
                  ? Row(
                      children: [
                        Text(
                          'Aplly',
                          style: bTextStyle,
                        ),
                        Icon(Icons.library_add_check_rounded),
                      ],
                    )
                  : null,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.04),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              UserPicture(
                                size: width * 0.4,
                                user: widget.user,
                              ),
                              widget.isMe
                                  ? Positioned(
                                      child: InkWell(
                                        child: editIcon,
                                        onTap: () async {
                                          //   File image = await FilePicker.getFile(
                                          //     type: FileType.image,
                                          //   );
                                          //   if (image != null) {
                                          //     widget.user.picture =
                                          //         FileImage(image);
                                          //   }

                                          //   setState(() {});
                                        },
                                      ),
                                      bottom: 5,
                                      right: 5,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(height: height * 0.03),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.user.userName.toUpperCase(),
                                style: bUserNameStyle,
                              ),
                              widget.isMe ? editIcon : SizedBox(),
                            ],
                          ),
                          SizedBox(height: height * 0.04),
                          DropDownCountriesMenu(
                            value: myCountry,
                            onChange: (value) {
                              setState(() {
                                myCountry = value;
                              });
                            },
                          ),
                          SizedBox(height: height * 0.04),
                          EmailField(controller: emailController),
                          SizedBox(height: height * 0.04),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Divider(color: Colors.black),
                                ),
                                Text(' Course made by me '),
                                Expanded(
                                  flex: 1,
                                  child: Divider(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          for (int i = 0;
                              i < widget.user.purchasedCourses.length && i < 2;
                              i++)
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                              ),
                              child: SearchResultItem(
                                course: widget.user.purchasedCourses[i],
                              ),
                            ),
                          widget.user.purchasedCourses.length >= 2
                              ? Container(child: Text('Show more'))
                              : SizedBox(),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownCountriesMenu extends StatelessWidget {
  final Function onChange;
  final String value;

  const DropDownCountriesMenu({Key key, this.onChange, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: width * 0.05),
      Text("From : "),
      SizedBox(width: width * 0.05),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: DropdownButton(
          value: this.value,
          underline: Container(),
          onChanged: onChange,
          items: <DropdownMenuItem>[
            for (int i = 0; i < countries.length; i++)
              DropdownMenuItem(
                child: Text(countries[i]),
                value: countries[i],
              ),
          ],
        ),
      ),
    ]);
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  const EmailField({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        Text("Email : "),
        SizedBox(width: width * 0.05),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.1),
      ],
    );
  }
}
