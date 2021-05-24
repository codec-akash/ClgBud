import 'package:clgbud/model/user_model.dart';
import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/http_exception.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final UserModel user;
  UserProfileCard({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        boxShadow: Global().boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${user.username}",
            style: Global().textStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${user.rollno}"),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.whatshot_sharp),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        Global().sendWhatsapp(user.phoneNumber);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.sms),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        try {
                          Global().sendSms(user.phoneNumber);
                        } on HttpException catch (e) {
                          print(e);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        Global().makeCall(user.phoneNumber);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
