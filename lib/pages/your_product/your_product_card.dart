import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class YourProdCard extends StatelessWidget {
  final ProductModel userProduct;
  YourProdCard({this.userProduct});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: Global().borderRadius,
        color: Colors.white,
        boxShadow: Global().boxShadow,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: Global().borderRadius,
            child: Container(
              width: AppMediaQuery(context).appWidth(25),
              height: AppMediaQuery(context).appHeight(15),
              child: FadeInImage(
                placeholder: AssetImage("images/product-placeholder.png"),
                image: NetworkImage(userProduct.productImage),
                fadeOutCurve: Curves.bounceOut,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            width: AppMediaQuery(context).appWidth(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userProduct.productName),
                Text(
                  "Date :: ${userProduct.addedDate?.toIso8601String() ?? DateTime.now().toIso8601String()}",
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Text("Price :: ${userProduct.amount}"),
                // Text(userProduct.isSold ? "Solded" : "Pending"),
                RichText(
                  text: TextSpan(
                      text: "Status  ::  ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      children: [
                        TextSpan(
                            text: userProduct.isSold ? "Solded" : "Pending",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0))
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
