import 'package:clgbud/pages/home_page/drawer_screen.dart';
import 'package:clgbud/pages/home_page/home_screen.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("ReachedDidChange");
    Provider.of<UserDataBase>(context, listen: false).saveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
