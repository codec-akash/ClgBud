import 'package:clgbud/model/user_model.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String userID;
  UserProfileCard({this.userID});
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
      child: FutureBuilder<UserModel>(
        future: UserDataBase().getUserDetails(userID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          final UserModel userModel = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userModel.username}",
                style: Global().textStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${userModel.rollno}"),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.whatshot_sharp),
                          color: Theme.of(context).accentColor,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.sms),
                          color: Theme.of(context).accentColor,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          color: Theme.of(context).accentColor,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
