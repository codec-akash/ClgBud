import 'package:clgbud/services/auth.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xoffset = 0.0;
  double yoffset = 0.0;
  double scalefactor = 1;

  bool _isDrawerOpen = false;

  void animateHomeScreen() {
    if (_isDrawerOpen) {
      setState(() {
        xoffset = 0.0;
        yoffset = 0.0;
        scalefactor = 1;
        _isDrawerOpen = false;
      });
    } else {
      setState(() {
        xoffset = 230;
        yoffset = 150;
        scalefactor = 0.6;
        _isDrawerOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(scalefactor),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(_isDrawerOpen ? 20.0 : 0.0),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: _isDrawerOpen
                        ? Icon(
                            Icons.chevron_left,
                            size: 34,
                          )
                        : Icon(Icons.menu),
                    onPressed: () => animateHomeScreen(),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: Text("HOmePage"),
              ),
            ),
            Container(
              // width: double.infinity,
              child: RaisedButton(
                child: Text("Signout"),
                onPressed: () {
                  AuthService().signout();
                },
              ),
            ),
            RaisedButton(
              child: Text("text"),
              onPressed: () {
                print(Provider.of<UserDataBase>(context, listen: false).userId);
              },
            )
          ],
        ),
      ),
    );
  }
}
