import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GridTile(
        child: Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: FadeInImage(
              placeholder: AssetImage('images/product-placeholder.png'),
              image: NetworkImage(product.productImage),
              fit: BoxFit.cover,
              fadeOutCurve: Curves.easeOut,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Column(
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
          trailing: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
