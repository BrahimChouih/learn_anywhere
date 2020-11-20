import 'package:flutter/material.dart';
import 'package:learn_anywhere/auth/auth_methods.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          AuthMethods.signOut();
        },
      ),
    );
  }
}
