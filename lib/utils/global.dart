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

  TextStyle textStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle detailText = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black);

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

  BorderRadiusGeometry borderRadius = BorderRadius.circular(10.0);

  BorderRadiusGeometry customBorderRadius(double r) {
    return BorderRadius.circular(r);
  }

  SizedBox height15Box = SizedBox(height: 15.0);

  SizedBox height10Box = SizedBox(height: 10.0);

  Divider horizontalDivider = Divider(
    color: Colors.grey,
    thickness: 0.9,
  );

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

  List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black54,
      blurRadius: 2.0,
      spreadRadius: 0.0,
      offset: Offset(4.0, 2.0), // shadow direction: bottom right
    )
  ];
}
