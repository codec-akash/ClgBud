import 'dart:convert';

import 'package:clgbud/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserDataBase with ChangeNotifier {
  UserModel userModel;
  String userId;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel get userData => userModel;

  void initialiseUser(
      {String username,
      String phoneNumber,
      String rollNo,
      String userId,
      bool isUserComplete}) async {
    userModel = UserModel(
      userId: userId,
      username: username,
      phoneNumber: phoneNumber,
      rollno: rollNo,
      isUserComplete: isUserComplete,
    );
    this.userId = userId;
    await userCollection.doc(userId).set(userModel.toJson());
  }

  void saveUserData() async {
    userId = _firebaseAuth.currentUser.uid;
    DocumentSnapshot userDataSnap = await userCollection.doc(userId).get();
    userModel = UserModel.fromJson(userDataSnap.data());
    print(userModel.isUserComplete);
  }
}
