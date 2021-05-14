import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  TextStyle headingText = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle buttonText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  InputDecoration textFieldDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  BorderRadiusGeometry borderRadius = BorderRadius.circular(5.0);

  BorderRadiusGeometry customBorderRadius(double r) {
    return BorderRadius.circular(r);
  }

  SizedBox height10Box = SizedBox(height: 15.0);

  List<BoxShadow> boxShadow = [
    BoxShadow(
        color: Color.fromRGBO(84, 110, 247, 0.3),
        blurRadius: 10.0,
        spreadRadius: 2.0,
        offset: Offset(0, 2))
  ];

  List<BoxShadow> buttonBoxShadow = [
    BoxShadow(
        color: Color.fromRGBO(84, 110, 247, 0.1),
        blurRadius: 5.0,
        spreadRadius: 2.0,
        offset: Offset(0, 0))
  ];

  List<BoxShadow> boxShadowLowBlur = [
    BoxShadow(
        color: Color.fromRGBO(84, 110, 247, 0.3),
        blurRadius: 8.0,
        spreadRadius: 0.0,
        offset: Offset(0, 3))
  ];

  List<BoxShadow> bottomBarShadow = [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.25),
        blurRadius: 15.0,
        spreadRadius: 2.0,
        offset: Offset(15.0, 15.0))
  ];

  List<BoxShadow> mainThemeButtonShadow = [
    BoxShadow(
        color: Color.fromRGBO(84, 110, 247, 0.3),
        blurRadius: 40.0,
        spreadRadius: 2.0,
        offset: Offset(0, 25))
  ];
}
