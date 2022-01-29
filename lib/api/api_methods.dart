import 'package:dio/dio.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/models/reviewer.dart';
import 'package:learn_anywhere/models/user.dart';

const api = 'http://192.168.1.130:8000';
// const api = 'https://brahim-chouih-learn-anywhere.herokuapp.com';
// const api = 'https://brahimchouih.pythonanywhere.com/';
Dio dio = Dio();

class APIMethods {
  static Options options;
  static Future<User> getUserInfo({int id = 0}) async {
    String apiUrl = '$api/api/auth/userinfo/$id/';

    options = Options(headers: {
      'Authorization': 'token ${AuthMethods.apiToken}',
    });

    Response response = await dio
        .get(apiUrl, options: options)
        .timeout(Duration(seconds: 15), onTimeout: () {
      throw Exception('Check your internet connection !!');
    });
    return User(response.data);
  }

  static Future<List<Course>> getCoursesMadeByUser({int id}) async {
    id == null ? id = AuthMethods.user.id : null;

    String apiUrl = '$api/api/coursesMadeByUser/$id/';

    Response response = await dio
        .get(apiUrl, options: options)
        .timeout(Duration(seconds: 15), onTimeout: () {
      throw Exception('There is an error !!!');
    });
    List<Course> courses = [];
    response.data.forEach((course) {
      courses.add(Course(course));
    });

    if (id == AuthMethods.user.id && courses.isNotEmpty) {
      AuthMethods.user.coursesMadeByUser = courses;
    }

    return courses.reversed.toList();
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

  static Future<Response> updateUserInfo(Map<String, dynamic> userData) async {
    String apiUrl = '$api/api/auth/userinfo/${AuthMethods.user.id}/';

    FormData formdata = FormData.fromMap(userData);
    Response response;
    response = await dio
        .post(
      apiUrl,
      data: formdata,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    return response;
  }

  static Future<List<Reviewer>> getReviewersOnCourse(int courseId) async {
    String apiUrl = '$api/api/reviewers/$courseId/';

    Response response = await dio.get(apiUrl, options: options);

    List<Reviewer> reviewers = [];

    response.data.forEach((reviewer) {
      reviewers.add(Reviewer(reviewer));
    });

    return reviewers;
  }

  static Future<Reviewer> addReviewOnCourse(Reviewer reviewer) async {
    String apiUrl = '$api/api/reviewers/';

    Map<String, dynamic> data = reviewer.toJson();

    Response response = await dio.post(apiUrl, data: data, options: options);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Reviewer(response.data);
    } else {
      throw DioError(
        requestOptions: RequestOptions(path: apiUrl),
        response: response,
        type: DioErrorType.response,
      );
    }
  }
}
