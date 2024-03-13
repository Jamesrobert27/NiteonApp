import 'package:flutter/material.dart';
class Navigation {
  static forever(BuildContext context, {required String screenRoute}) {
    Navigator.pushNamedAndRemoveUntil(
        context, screenRoute, (route) => false);
  }

  static forward(BuildContext context, {required String screenRoute}) {
    Navigator.pushNamed(context, screenRoute);
  }

  static out(context) {
    Navigator.pop(context);
  }
}
