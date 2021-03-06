import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:learn_anywhere/api/api_methods.dart';
import 'package:learn_anywhere/models/user.dart';
import 'package:learn_anywhere/screens/auth_screens/sign_in_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  static String apiToken;
  static User user;
  static SharedPreferences sharedPreferences;

  static void signIn({String email, String password}) async {
    String apiUrl = '$api/api/auth/login/';

    Response response = await dio.post(
      apiUrl,
      data: {
        'username': email,
        'password': password,
        // 'username': 'brahim@gmail.com',
        // 'password': 'anabrahim',
      },
    );
    apiToken = response.data['token'];
    print(apiToken);
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('apiToken', apiToken);
    user = await APIMethods.getUserInfo();
    print(user.email);
  }

  static void signUp({String email, String username, String password}) async {
    String apiUrl = '$api/api/auth/register/';

    Response response = await dio.post(
      apiUrl,
      data: {
        'email': email,
        'username': username,
        'password': password,
        // 'email': 'test2@gmail.com',
        // 'username': 'test2',
        // 'password': '123456',
        'picture': null,
        'country': null,
      },
    );
    apiToken = response.data['token'];
    if (apiToken == null) {
      throw response.data;
    }
    print(apiToken);
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('apiToken', apiToken);
    user = await APIMethods.getUserInfo();
  }

  static void signOut() async {
    await sharedPreferences.clear();
    apiToken = null;
    user = null;
    getx.Get.offAndToNamed(SignInUpScreen.idSignIn);
    getx.Get.reset();
  }

  static Future<void> getTokenFromSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    apiToken = sharedPreferences.getString('apiToken');
    if (apiToken != null) {
      user = await APIMethods.getUserInfo();
    }
  }

  static Future<void> refreshUserInfo() async {
    user = await APIMethods.getUserInfo();
  }
}
