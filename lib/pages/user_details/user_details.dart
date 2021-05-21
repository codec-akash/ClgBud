import 'package:clgbud/model/user_model.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  static const routeName = "/user-details";
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  UserModel userData;

  bool iscomplete = false;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    userData = Provider.of<UserDataBase>(context, listen: false).userData;
    super.didChangeDependencies();
  }

  void updateUserDetials() {
    if (isLoading) {
      _scaffold.currentState.hideCurrentSnackBar();
      _scaffold.currentState
          .showSnackBar(SnackBar(content: Text("Updating user please wait")));
    } else {
      if (_formKey.currentState.validate()) {
        _scaffold.currentState.showBodyScrim(true, 0.4);
        setState(() {
          isLoading = true;
        });
        try {
          Provider.of<UserDataBase>(context, listen: false).initialiseUser(
            username: userData.username,
            phoneNumber: userData.phoneNumber,
            rollNo: userData.rollno,
            userId: userData.userId,
            isUserComplete: true,
          );
          _scaffold.currentState
              .showSnackBar(SnackBar(content: Text("User Updated")));
        } catch (e) {
          print(e);
        }
        _scaffold.currentState.showBodyScrim(false, 0.4);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyBoardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Your Details"),
      ),
      floatingActionButton: keyBoardVisible
          ? null
          : Container(
              width: MediaQuery.of(context).size.width - 36,
              padding: EdgeInsets.only(right: 4),
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: isLoading
                    ? SpinKitThreeBounce(color: Colors.white, size: 24)
                    : Text("Submit"),
                onPressed: () {
                  updateUserDetials();
                },
              ),
            ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: userData.username,
                decoration: Global()
                    .textFieldDecoration
                    .copyWith(labelText: 'Your Name'),
                validator: (value) {
                  if (value.length <= 2) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                onChanged: (value) {
                  userData.username = value;
                },
              ),
              Global().height15Box,
              TextFormField(
                initialValue: userData.rollno,
                decoration: Global()
                    .textFieldDecoration
                    .copyWith(labelText: 'Roll Number'),
                validator: (value) {
                  if (value.length < 3) {
                    return "Do enter a valid roll number";
                  }
                  return null;
                },
                onChanged: (value) {
                  userData.rollno = value;
                },
              ),
              Global().height15Box,
              TextFormField(
                initialValue: userData.phoneNumber,
                decoration: Global().textFieldDecoration.copyWith(
                      labelText: "Phone Number",
                    ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.length < 10) {
                    return "Valid PhoneNUmber would be helpful";
                  }
                  return null;
                },
                onChanged: (value) {
                  userData.phoneNumber = "+91" + value;
                },
              ),
              Global().height15Box,
            ],
          ),
        ),
      ),
    );
  }
}
