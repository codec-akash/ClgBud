import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/home_page/user_profile_card.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  ProductDetails({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 36,
        padding: EdgeInsets.only(right: 4),
        height: 50,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text("Buy Now"),
          onPressed: () {},
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text("${product.productName}"),
              centerTitle: true,
              floating: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(250.0),
                child: Container(
                  height: 250.0,
                  color: Colors.white,
                  width: double.infinity,
                  child: FadeInImage(
                    placeholder: AssetImage('images/product-placeholder.png'),
                    image: NetworkImage(product.productImage),
                    fit: BoxFit.cover,
                    fadeOutCurve: Curves.easeOut,
                  ),
                ),
              ),
              // expandedHeight: 250.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Container(
              //     height: 250.0,
              //     color: Colors.white,
              //     width: double.infinity,
              //     child: FadeInImage(
              //       placeholder: AssetImage('images/product-placeholder.png'),
              //       image: NetworkImage(product.productImage),
              //       fit: BoxFit.cover,
              //       fadeOutCurve: Curves.easeOut,
              //     ),
              //   ),
              // ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Global().height15Box,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: Global().borderRadius,
                      boxShadow: Global().bottomBarShadow,
                      border: Border.all(color: Colors.black26),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
                      ),
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
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Global().height15Box,
                Global().height15Box,
                RichText(
                  text: TextSpan(
                    text: "Name ::   ",
                    style: Global().textStyle,
                    children: [
                      TextSpan(
                        text: "${product.productName}",
                        style:
                            Global().headingText.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Global().height15Box,
                RichText(
                  text: TextSpan(
                    text: "Price ::   ",
                    style: Global().textStyle,
                    children: [
                      TextSpan(
                          text: "${product.amount}",
                          style: Global().detailText),
                    ],
                  ),
                ),
                Global().horizontalDivider,
                Text(
                  "Description",
                  style: Global().headingText,
                ),
                Global().height15Box,
                RichText(
                  text: TextSpan(
                    text: "Course ::   ",
                    style: Global().textStyle,
                    children: [
                      TextSpan(
                          text: "${product.course}",
                          style: Global().detailText),
                    ],
                  ),
                ),
                Global().height15Box,
                RichText(
                  text: TextSpan(
                    text: "Category ::   ",
                    style: Global().textStyle,
                    children: [
                      TextSpan(
                          text: "${product.category}",
                          style: Global().detailText),
                    ],
                  ),
                ),
                Global().height15Box,
                Text(
                  product.productDescription ??
                      "Nothing special mention from user",
                  style: Global().detailText,
                ),
                Global().height10Box,
                Global().horizontalDivider,
                Text(
                  "About Publisher",
                  style: Global().headingText,
                ),
                Global().height10Box,
                UserProfileCard(userID: product.userId)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
