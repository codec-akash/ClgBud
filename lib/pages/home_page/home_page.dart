import 'package:clgbud/pages/home_page/drawer_screen.dart';
import 'package:clgbud/pages/home_page/home_screen.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      print("ReachedDidChange");
      final userSnap = Provider.of<UserDataBase>(context, listen: false);
      userSnap.saveUserData();
      Provider.of<ProductDataBase>(context, listen: false).getDropDowns();
      Provider.of<ProductDataBase>(context, listen: false)
          .getWishList(userSnap.userId);
    }
    isInit = false;
    super.didChangeDependencies();
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
