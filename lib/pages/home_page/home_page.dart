import 'dart:html';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("HOmePage"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Center(
          child: Text("HOmePage"),
        ),
      ),
    );
  }
}
