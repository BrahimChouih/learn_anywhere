import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_anywhere/components/user_picture.dart';
import 'package:learn_anywhere/models/course.dart';
import 'package:learn_anywhere/models/reviewer.dart';
import 'package:learn_anywhere/themes/primary_theme.dart';
import 'package:learn_anywhere/themes/size.dart';

import 'home_components.dart';

class CommentItem extends StatelessWidget {
  final Reviewer reviewer;
  const CommentItem({Key key, this.reviewer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5),
      child: Row(
        children: [
          UserPicture(
            picture: reviewer.owner.picture,
            size: width * 0.2,
          ),
          SizedBox(width: 10),
          Column(
            // mainAxisAlignment: MainAxisAlignment.,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reviewer.owner.userName.toUpperCase(),
                style: bUserNameStyle,
              ),
              RateStars(rate: reviewer.stars),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: width * 0.7,
                    child: Text(
                      reviewer.comment,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WriteAComment extends StatefulWidget {
  final Course course;
  WriteAComment({Key key, this.course}) : super(key: key);

  @override
  _WriteACommentState createState() => _WriteACommentState();
}

class _WriteACommentState extends State<WriteAComment> {
  double stars = 0;
  TextEditingController commectController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 11.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 11),
          TextField(
            decoration: InputDecoration(
              hintText: 'write your comment here !!!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            controller: commectController,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              pmButton(Icons.remove),
              RateStars(rate: stars),
              pmButton(Icons.add),
            ],
          ),
          Text(stars.toString()),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  Reviewer reviewer = new Reviewer({
                    'comment': commectController.text,
                    'comment_on': widget.course.toJson(),
                    'stars': stars,
                  });

                  Get.back<Map>(result: {
                    'submit': true,
                    'reviewer': reviewer,
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Get.back<Map>(result: {
                    'submit': false,
                    'reviewer': null,
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget pmButton(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        if (icon == Icons.add) {
          if (stars < 5) stars += 0.5;
        } else {
          if (stars > 0) stars -= 0.5;
        }
        setState(() {});
      },
    );
  }
}
