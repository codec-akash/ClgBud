import 'package:clgbud/services/auth.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Consumer<UserDataBase>(
          builder: (context, value, _) {
            return GestureDetector(
              child: Text(value?.userData?.username ?? "Click to add Info"),
              onTap: () {
                print("TODO");
              },
            );
          },
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Profile"),
                    leading: Icon(Icons.account_box_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Add Product"),
                    leading: Icon(Icons.add_circle_outline),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Your Products"),
                    leading: Icon(Icons.bolt),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Your Order"),
                    leading: Icon(CupertinoIcons.cart),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              child: ListTile(
                title: Text("LogOut"),
                leading: Icon(Icons.logout),
                onTap: () {
                  AuthService().signout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
