import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/components/login_comp.dart';
import 'package:learn_anywhere/screens/primary_screens/primary_screen.dart';
import 'package:learn_anywhere/themes/size.dart';
import 'package:learn_anywhere/themes/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInUpScreen extends StatefulWidget {
  static const idSignIn = 'signInScreen';
  static const idSignUp = 'signUpScreen';

  final AuthMode authMode;

  SignInUpScreen(this.authMode);

  @override
  _SignInUpScreenState createState() => _SignInUpScreenState();
}

class _SignInUpScreenState extends State<SignInUpScreen> {
  bool isSignIn;
  bool inAsyncCall = false;

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController username = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    isSignIn = widget.authMode == AuthMode.SginIn;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Container(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: SvgPicture.asset(
                      isSignIn
                          ? 'assets/draw/signin.svg'
                          : 'assets/draw/signup.svg',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: height * 0.05, bottom: height * 0.05),
                    child: Text(
                      'Learn anywhere',
                      style: bTitleStyle,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Divider(color: Colors.black),
                      ),
                      Text(isSignIn ? '  Sign In  ' : '  Sign up  ',
                          style: bTitleStyle),
                      Expanded(
                        flex: 1,
                        child: Divider(color: Colors.black),
                      ),
                    ],
                  ),
                  EmailPasswordField(hintText: 'Email', controller: email),
                  !isSignIn
                      ? EmailPasswordField(
                          hintText: 'username', controller: username)
                      : Container(),
                  EmailPasswordField(
                      hintText: 'Password', controller: password),
                  SubmitButton(
                    lable: 'Login',
                    onTap: onClick,
                  ),
                  TextButton(
                    onPressed: () {
                      isSignIn
                          ? Get.offAndToNamed(SignInUpScreen.idSignUp)
                          : Get.offAndToNamed(SignInUpScreen.idSignIn);
                    },
                    child: Text(
                      isSignIn ? 'Sign Up' : 'Sign In',
                      style: TextStyle(
                        color: Get.theme.textSelectionHandleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClick() async {
    setState(() {
      inAsyncCall = true;
    });
    try {
      await (isSignIn
          ? AuthMethods.signIn(
              email: email.text,
              password: password.text,
            )
          : AuthMethods.signUp(
              email: email.text,
              username: username.text,
              password: password.text,
            ));
    } catch (e) {
      String error;
      try {
        error = e.response.data.toString();

        print("fkjdhfjhdskhafkhsdaklffds");
      } catch (v) {
        error = e.toString();
        print(e);
      }
      error = error.substring(1, error.lastIndexOf('}'));
      // error[1];

      Get.defaultDialog(
        title: 'Error',
        content: Text(error),
        confirm: FlatButton(
          onPressed: () {
            Get.back();
            print('===============');
          },
          child: Text('Ok'),
        ),
        buttonColor: Get.theme.primaryColor,
      );
    }

    if (AuthMethods.apiToken != null) {
      Get.offAndToNamed(PrimaryScreen.idPrimaryScreen);
    }
    setState(() {
      inAsyncCall = false;
    });
  }
}

enum AuthMode {
  SginIn,
  SginUp,
}
