import 'package:dio/dio.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/models/user.dart';

const api = 'http://192.168.1.30:8000';
Dio dio = Dio();

class APIMethods {
  static Future<User> getUserInfo() async {
    String apiUrl = '$api/api/auth/userinfo/0/';
    Options options = Options(headers: {
      'Authorization': 'token ${AuthMethods.apiToken}',
    });

    Response response = await dio.get(apiUrl, options: options);
    return User(response.data);
  }
}
