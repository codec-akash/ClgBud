import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataBase>(context, listen: false);
    final prodData = Provider.of<ProductDataBase>(context, listen: false);
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
                "${product.productName}",
                softWrap: false,
                style: Global().textStyle.copyWith(color: Colors.white),
              ),
              Text(
                "Price :: ${product.amount}",
                style: Global().textStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
          trailing: Consumer<ProductModel>(
            builder: (context, prod, _) {
              return IconButton(
                icon: Icon(
                    prod.isWishlisted ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  prod.toggleFavoriteStatus(userData.userId);
                  prodData.updateWishList(product.productId);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
