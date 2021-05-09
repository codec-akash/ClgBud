import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/http_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String status;
  bool _isnewUser = false;

  String get statusmessage => status;

  Stream get user {
    return _firebaseAuth.authStateChanges();
  }

  bool get isNewUser => _isnewUser;

  Future signINWithGoogle() async {
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
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signINWithPhone(
      String phoneNumber, BuildContext context, Function showErrorMsg) async {
    TextEditingController _codeController = TextEditingController();
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Navigator.of(context).pop();
          try {
            UserCredential userCredential =
                await _firebaseAuth.signInWithCredential(credential);
          } catch (e) {
            status = "Error Occured while sign -in";
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Fialed");
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
                        UserCredential userCredential = await _firebaseAuth
                            .signInWithCredential(authCredential);
                        // print(userCredential.user.phoneNumber);
                      } catch (e) {
                        showErrorMsg(e.toString());
                        print("REached HEre code");
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("reached main catch");
      status = "Error Occured";
      print(e);
    }
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
