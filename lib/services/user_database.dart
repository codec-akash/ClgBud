import 'package:clgbud/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserDataBase with ChangeNotifier {
  UserModel userModel;
  void initialiseUser(
      {String username,
      String phoneNumber,
      String rollNo,
      String userId,
      bool isUserComplete}) {
    userModel = UserModel(
      userId: userId,
      username: username,
      phoneNumber: phoneNumber,
      rollno: rollNo,
      isUserComplete: isUserComplete,
    );
  }
}
