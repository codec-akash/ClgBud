import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String status;
  String userId;
  bool _isnewUser = false;
  bool _isLoading = false;

  String get statusmessage => status;

  bool get isLoading => _isLoading;

  Stream get user {
    if (_firebaseAuth.currentUser != null) {
      userId = _firebaseAuth.currentUser.uid;
    }
    return _firebaseAuth.authStateChanges();
  }

  bool get isNewUser => _isnewUser;

  Future signINWithGoogle() async {
    _isLoading = true;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oAuthCredential);
      if (userCredential.additionalUserInfo.isNewUser) {
        UserDataBase().initialiseUser(
          phoneNumber: userCredential.user.phoneNumber,
          isUserComplete: false,
          userId: userCredential.user.uid,
        );
      }
      userId = userCredential.user.uid;
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> signINWithPhone(
      String phoneNumber, BuildContext context, Function showErrorMsg) async {
    TextEditingController _codeController = TextEditingController();
    try {
      _isLoading = true;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential userCredential =
                await _firebaseAuth.signInWithCredential(credential);
            if (userCredential.additionalUserInfo.isNewUser) {
              UserDataBase().initialiseUser(
                phoneNumber: userCredential.user.phoneNumber,
                isUserComplete: false,
                userId: userCredential.user.uid,
              );
            }
            userId = userCredential.user.uid;
            _isLoading = false;
            Navigator.of(context).pop();
            print("VErification Complete");
          } catch (e) {
            status = "Error Occured while sign -in";
            _isLoading = false;
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Fialed");
          _isLoading = false;
          status = e.message;
          showErrorMsg(e.message);
          throw HttpException(e.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _codeController,
                      decoration: Global().textFieldDecoration,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                    child: Text("Verify"),
                    onPressed: () async {
                      try {
                        Navigator.of(context).pop();
                        AuthCredential authCredential =
                            PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: _codeController.text.trim(),
                        );
                        _isLoading = false;
                        UserCredential userCredential = await _firebaseAuth
                            .signInWithCredential(authCredential);
                        if (userCredential.additionalUserInfo.isNewUser) {
                          UserDataBase().initialiseUser(
                            phoneNumber: userCredential.user.phoneNumber,
                            isUserComplete: false,
                            userId: userCredential.user.uid,
                          );
                        }
                        userId = userCredential.user.uid;
                      } catch (e) {
                        _isLoading = false;
                        showErrorMsg(e.toString());
                        print("REached HEre code");
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      _isLoading = false;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto Retriveal");
        },
      );
    } catch (e) {
      print("reached main catch");
      status = "Error Occured";
      _isLoading = false;
      print(e);
    }
    notifyListeners();
  }

  Future signout() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
