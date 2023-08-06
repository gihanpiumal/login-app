import 'package:flutter/material.dart';

class UtilFunctions {
  /// navigator function

  void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
