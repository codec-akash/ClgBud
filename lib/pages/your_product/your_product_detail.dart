import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/pages/add_product/add_product.dart';
import 'package:clgbud/pages/your_product/interested_card.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/date_time_util.dart';
import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class YourProdDetail extends StatelessWidget {
  final ProductModel productModel;
  YourProdDetail({this.productModel});

  void deleteProduct(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Delete Product"),
          content: Text("Soch lo ek aur baar.."),
          actions: [
            CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: () {
                try {
                  Provider.of<ProductDataBase>(context, listen: false)
                      .deleteProduct(productModel.productId)
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("$e")));
                }
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${productModel.productName}"),
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
                          onPressed: () {
                            Share.share(
                                "HEyy Check out this product named : ${productModel.productName}");
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteProduct(context);
                          },
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
              Text("Course :: ${productModel.course} ",
                  style: Global().detailText),
              Text("Category :: ${productModel.category} ",
                  style: Global().detailText),
              Global().height10Box,
              Global().horizontalDivider,
              Text("Interested People", style: Global().headingText),
              Global().height10Box,
              Consumer<ProductModel>(
                builder: (context, prod, _) {
                  return StreamBuilder<List<String>>(
                    stream: prod.interestedPeople,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading();
                      }
                      if (snapshot.hasError) {
                        print("Resached ${snapshot.error}");
                        Text("${snapshot.error}");
                      }
                      print("Resached");
                      return Column(
                        children: snapshot.data
                            .map((e) => InterestedCard(
                                  userID: e,
                                ))
                            .toList(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
