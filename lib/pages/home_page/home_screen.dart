import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/home_page/product_list.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/loading.dart';
import 'package:flutter/material.dart';

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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: _isDrawerOpen
                        ? Icon(
                            Icons.chevron_left,
                            size: 34,
                          )
                        : Icon(Icons.menu),
                    onPressed: () => animateHomeScreen(),
                  ),
                  SizedBox(width: 10.0),
                  Text("ClgBud", style: Global().headingText),
                ],
              ),
              Global().height10Box,
              Text(
                "Items Available For Sale",
                style: Global().headingText,
              ),
              StreamBuilder<List<ProductModel>>(
                stream: ProductDataBase().allProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Loading());
                  }
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    return Expanded(
                      child: ProductList(productList: snapshot.data),
                    );
                  }
                  return Loading();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
