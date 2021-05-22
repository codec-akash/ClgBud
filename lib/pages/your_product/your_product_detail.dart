import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/add_product/add_product.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/date_time_util.dart';
import 'package:clgbud/utils/global.dart';
import 'package:flutter/material.dart';

class YourProdDetail extends StatelessWidget {
  final ProductModel productModel;
  YourProdDetail({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: Global().borderRadius,
                      child: Container(
                        height: AppMediaQuery(context).appHeight(35),
                        child: FadeInImage(
                          placeholder:
                              AssetImage("images/product-placeholder.png"),
                          image: NetworkImage(productModel.productImage),
                          fadeOutCurve: Curves.bounceOut,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: AppMediaQuery(context).appHeight(25),
                    width: AppMediaQuery(context).appWidth(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => AddProduct(
                                          editedProduct: productModel,
                                        )));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Global().height15Box,
              Text(
                "${productModel.productName}",
                style: Global().headingText,
              ),
              Global().height10Box,
              RichText(
                text: TextSpan(
                  text: "Date  :: ",
                  style: Global().textStyle,
                  children: [
                    TextSpan(
                      text:
                          "${DateUtil().dateformatDefault(DateTime.tryParse(productModel.addedDate) ?? DateTime.now())}",
                      style: Global().detailText,
                    ),
                  ],
                ),
              ),
              Global().height10Box,
              RichText(
                text: TextSpan(
                  text: "Price  :: ",
                  style: Global().textStyle,
                  children: [
                    TextSpan(
                      text: "${productModel.amount}",
                      style: Global().detailText,
                    ),
                  ],
                ),
              ),
              Global().height10Box,
              RichText(
                text: TextSpan(
                  text: "Status  :: ",
                  style: Global().textStyle,
                  children: [
                    TextSpan(
                      text: productModel.isSold ? "Solded" : "Pending",
                      style: Global().detailText,
                    ),
                  ],
                ),
              ),
              Global().height10Box,
              Global().horizontalDivider,
              Text("Description", style: Global().headingText),
              Global().height15Box,
              Text(productModel.productDescription ?? "No Description Provided",
                  style: Global().detailText),
              Global().height10Box,
              Global().horizontalDivider,
              Text("Interested People", style: Global().headingText),
            ],
          ),
        ),
      ),
    );
  }
}
