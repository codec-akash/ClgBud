import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/your_product/your_product_card.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourProducts extends StatelessWidget {
  static const routeName = "/user-products";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataBase>(context, listen: false);
    final products = Provider.of<ProductDataBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
      ),
      // backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
        child: FutureBuilder<List<ProductModel>>(
            future: products.userProducts(user.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              final userProducts = snapshot.data ?? [];
              return ListView.builder(
                itemCount: userProducts.length,
                itemBuilder: (context, index) =>
                    YourProdCard(userProduct: userProducts[index]),
              );
            }),
      ),
    );
  }
}
