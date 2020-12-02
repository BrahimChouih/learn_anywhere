import 'package:dio/dio.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/models/user.dart';

const api = 'http://192.168.1.30:8000';
// const api = 'https://brahimchouih.pythonanywhere.com/';
Dio dio = Dio();

class APIMethods {
  static Options options = Options(headers: {
    'Authorization': 'token ${AuthMethods.apiToken}',
  });
  static Future<User> getUserInfo() async {
    String apiUrl = '$api/api/auth/userinfo/0/';

    Response response = await dio.get(apiUrl, options: options);
    return User(response.data);
  }

  static Future<List<Course>> getAllCourses({String id}) async {
    String apiUrl = '$api/api/courses/';

    if (id != null) {
      apiUrl = apiUrl + id + '/';
    }

    Response response = await dio.get(apiUrl, options: options);

    List<Course> courses = [];
    response.data.forEach((course) {
      courses.add(Course(course));
    });
    return courses.reversed.toList();
  }
}
