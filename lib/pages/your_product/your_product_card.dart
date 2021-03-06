import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/your_product/your_product_detail.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/date_time_util.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourProdCard extends StatelessWidget {
  final ProductModel userProduct;
  YourProdCard({this.userProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: userProduct,
              child: YourProdDetail(
                productModel: userProduct,
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: Global().borderRadius,
          color: Colors.white,
          boxShadow: Global().elevatedShadow,
        ),
        child: Row(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userProduct.productName),
                  if (userProduct.addedDate != null)
                    Text(
                      "Date :: ${DateUtil().dateformatDefault(DateTime.parse(userProduct.addedDate))}",
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  Text("Price :: ${userProduct.amount}"),
                  RichText(
                    text: TextSpan(
                        text: "Status  ::  ",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        children: [
                          TextSpan(
                              text: userProduct.isSold ? "Solded" : "Pending",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0))
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
