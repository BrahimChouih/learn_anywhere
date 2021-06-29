import 'dart:io';
import 'package:learn_anywhere/controllers/app_bar_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/second_app_bar.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/models/user.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/utils/utils.dart';
import 'profile_components.dart';

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
  String userName;
  FileImage picture;
  TextEditingController emailController;

  // wait get courses made by this user
  bool isLoading = true;

  // wait update user info
  bool isUploading = false;

  int numberCourseMadeByUser = 0;
  bool showMore = false;
  final AppBarController appBarController = Get.find<AppBarController>();

  Future<void> initData({bool getCoursesMadeByUser = false}) async {
    // if this profile is mine
    if (widget.isMe) {
      widget.user = AuthMethods.user;
    }

    // init this iniformations
    myCountry = widget.user.country;
    userName = widget.user.userName;
    emailController = new TextEditingController(
      text: widget.user.email,
    );

    // init courses made by this user
    if (widget.user.coursesMadeByUser.isEmpty || getCoursesMadeByUser) {
      widget.user.coursesMadeByUser = await APIMethods.getCoursesMadeByUser(
        id: widget.user.id,
      );
    }

    // how many courses show
    if (widget.user.coursesMadeByUser.length > 2) {
      showMore = true;
      numberCourseMadeByUser = 2;
    } else {
      showMore = false;
      numberCourseMadeByUser = widget.user.coursesMadeByUser.length;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isUploading,
          child: Column(
            children: [
              SecondAppBar(
                title: Text(
                  widget.isMe ? 'My Profile' : 'Profile',
                  style: bTextStyle,
                ),
                trailing: widget.isMe
                    ? InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          Map<String, dynamic> userData = {};

                          if (this.picture != null) {
                            userData["picture"] =
                                await dio.MultipartFile.fromFile(
                              picture.file.path,
                              filename: basename(picture.file.path),
                            );
                          }

                          this.userName != widget.user.userName
                              ? userData['username'] = userName
                              : null;

                          this.myCountry != widget.user.country &&
                                  this.myCountry != "No Selected"
                              ? userData['country'] = this.myCountry
                              : null;

                          try {
                            setState(() {
                              isUploading = true;
                            });
                            if (userData != {}) {
                              await APIMethods.updateUserInfo(userData);
                            }

                            await AuthMethods.refreshUserInfo();
                            appBarController.updateUserPicture();

                            Get.back();
                          } catch (e) {
                            print(e.response.data);
                            Get.snackbar(
                              "error",
                              e.response.data.toString(),
                              duration: Duration(seconds: 5),
                            );
                          }
                          setState(() {
                            isUploading = false;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Aplly',
                              style: bTextStyle,
                            ),
                            Icon(Icons.library_add_check_rounded),
                          ],
                        ),
                      )
                    : null,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      isUploading = true;
                    });

                    widget.user =
                        await APIMethods.getUserInfo(id: widget.user.id);
                    appBarController.updateUserPicture();

                    await initData(getCoursesMadeByUser: true);

                    setState(() {
                      isUploading = false;
                    });
                  },
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
                                    picture: picture == null
                                        ? widget.user.picture
                                        : picture,
                                  ),
                                  widget.isMe
                                      ? Positioned(
                                          child: InkWell(
                                            child: editIcon,
                                            onTap: () async {
                                              File image;
                                              try {
                                                image =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.image,
                                                )
                                                        .then((value) {
                                                  return File(value.paths[1]);
                                                });
                                              } catch (e) {
                                                print(e);
                                              }

                                              if (image != null) {
                                                picture = FileImage(image);
                                              }

                                              setState(() {});
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
                                    userName.toUpperCase(),
                                    style: bUserNameStyle,
                                  ),
                                  widget.isMe
                                      ? InkWell(
                                          child: editIcon,
                                          onTap: editUserName,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              SizedBox(height: height * 0.04),
                              DropDownCountriesMenu(
                                value: myCountry == null
                                    ? 'No Selected'
                                    : myCountry,
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
                              isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CoursesMadeByUserView(
                                      courses: widget.user.coursesMadeByUser,
                                      length: numberCourseMadeByUser,
                                    ),
                              showMore && !isLoading
                                  ? InkWell(
                                      onTap: () {
                                        showMore = false;
                                        numberCourseMadeByUser = widget
                                            .user.coursesMadeByUser.length;
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: Text('Show more'),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: height * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editUserName() {
    TextEditingController userNameController = new TextEditingController(
      text: this.userName,
    );
    Get.dialog(
      AlertDialog(
        content: EditUserNameDialog(
          controller: userNameController,
          onConfirm: () {
            this.userName = userNameController.text;
            setState(() {});
          },
        ),
      ),
    );
  }
}

//  FutureBuilder<List<Course>>(
//                                   future: APIMethods.getCoursesMadeByUser(
//                                       id: widget.user.id),
//                                   builder: (_, snapshot) {
//                                     print(snapshot.data);
//                                     if (!snapshot.hasData)
//                                       return Center(
//                                           child: CircularProgressIndicator());

//                                     showMore.value = snapshot.data.length > 1;

//                                     return Obx(
//                                       () => CoursesMadeByUserView(
//                                         courses: snapshot.data,
//                                         length: snapshot.data.length < 1 ||
//                                                 !showMore.value
//                                             ? snapshot.data.length
//                                             : 1,
//                                       ),
//                                     );
//                                   },
//                                 )
//                               :
