import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: Global().borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                product.productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            // height: 130,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: Global().borderRadius,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name :: ${product.productName}",
                  softWrap: false,
                  style: Global().textStyle,
                ),
                Text(
                  "Price :: ${product.amount}",
                  style: Global().textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
