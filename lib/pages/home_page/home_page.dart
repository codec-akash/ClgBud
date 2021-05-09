import 'package:clgbud/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("HOmePage"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text("HOmePage"),
            ),
          ),
          RaisedButton(
            onPressed: () {
              AuthService().signout();
            },
          )
        ],
      ),
    );
  }
}
