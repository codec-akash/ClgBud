import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/home_page/product_card.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> productList;
  ProductList({this.productList});

  @override
  Widget build(BuildContext context) {
    double itemHeight = AppMediaQuery(context).appHeight(35);
    double itemWidth = AppMediaQuery(context).appWidth(80);

    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemHeight / itemWidth,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => ProductCard(
        product: productList[index],
      ),
    );
  }
}
