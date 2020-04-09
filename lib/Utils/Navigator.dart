import 'package:flutter/material.dart';

class MyNavigator {
  static void goToSplash(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/splash");
  }
  static void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }
  static void goToPatient(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/patdash");
  }
}
