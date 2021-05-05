import 'package:clgbud/services/auth.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Shimmer.fromColors(
          baseColor: Colors.black,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          period: Duration(seconds: 6),
          child: Text("ClgBud", style: TextStyle(fontSize: 28)),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: AppMediaQuery(context).appHeight(8.0)),
                child: Text(
                  "Hello There !!",
                  style: Global().headingText,
                ),
              ),
              SizedBox(height: AppMediaQuery(context).appHeight(2.0)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Image.asset("images/login_image.png"),
              ),
              SizedBox(height: AppMediaQuery(context).appHeight(5.0)),
              Container(
                decoration: BoxDecoration(boxShadow: Global().boxShadow),
                child: TextFormField(
                  decoration: Global().textFieldDecoration.copyWith(
                      suffixIcon: Icon(Icons.phone), hintText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: AppMediaQuery(context).appHeight(10.0)),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: Global().borderRadius),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text("Login"),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(boxShadow: Global().boxShadowLowBlur),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: Global().borderRadius),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text("Google"),
                  onPressed: () async {
                    await AuthService().signINWithGoogle();
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "*All Authentication is done using firebase so its secure",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
