import 'user.dart';
import 'course.dart';

class Reviewer {
  int id;
  String comment;
  double stars;
  User owner;
  Course comment_on;

  Reviewer(Map<String, dynamic> map) {
    fromMap(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'stars': stars,
      'comment_on': comment_on?.id,
      'owner': owner?.id,
    };
  }

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.comment = map['comment'];
    this.stars = map['stars'];

    try {
      this.comment_on = Course(map['comment_on']);
    } catch (e) {}
    try {
      this.owner = User(map['owner']);
    } catch (e) {}
  }
}
