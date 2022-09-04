import 'package:flutter/material.dart';


Color inputDecorationBorderColor = Color.fromRGBO(200, 400, 34, 1);
InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: inputDecorationBorderColor, width: 2.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: inputDecorationBorderColor,
        width: 2.0,
      )));
}

class Data {
  static String appName = " Flutter and Firebase";
}
