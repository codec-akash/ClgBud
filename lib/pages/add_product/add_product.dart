import 'dart:io';

import 'package:clgbud/model/product_model.dart';
import 'package:clgbud/services/product_database.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/app_media_query.dart';
import 'package:clgbud/utils/global.dart';
import 'package:clgbud/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  static const routeName = "/add-page";
  final ProductModel editedProduct;
  AddProduct({this.editedProduct});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductModel productModel = ProductModel();

  String courseHint = "Choose a course";
  String categoryHint = "Choose a category";

  bool isLoading = false;
  bool isInit = true;

  List<String> courseList = [];
  List<String> categoryList;

  File _pickedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      print("object did");
      courseList = Provider.of<ProductDataBase>(context, listen: false).course;
      categoryList =
          Provider.of<ProductDataBase>(context, listen: false).category;

      if (widget.editedProduct != null) {
        setState(() {
          productModel = widget.editedProduct;
          print(productModel.productId);
          courseHint = productModel.course ?? "Choose a course";
          categoryHint = productModel.category ?? "Choose a category";
        });
      }
    }
    isInit = false;
    print("object did 2");
    super.didChangeDependencies();
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _pickedImage = File(pickedFile.path);
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Select a image"),
          ));
        }
      });
    } catch (e) {
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("$e"),
      ));
    }
  }

  void saveProduct() async {
    if (checkValidation()) {
      try {
        setState(() {
          isLoading = true;
        });
        _scaffoldKey.currentState.showBodyScrim(true, 0.5);

        if (widget.editedProduct != null) {
          print("Update CAlled");
          await Provider.of<ProductDataBase>(context, listen: false)
              .updateProduct(productModel, _pickedImage);
        } else {
          productModel.userId =
              Provider.of<UserDataBase>(context, listen: false).userId;
          productModel.addedDate = DateTime.now().toIso8601String();
          productModel.isSold = false;
          await Provider.of<ProductDataBase>(context, listen: false)
              .addProduct(
                  productModel: productModel, productImage: _pickedImage)
              .then((_) {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("Item Added")));
            clearData();
          });
        }
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$e")));
      }
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showBodyScrim(false, 0.5);
    }
  }

  bool checkValidation() {
    if (_formKey.currentState.validate()) {
      if (productModel.course == null || productModel.category == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Enter complete details"),
        ));
        return false;
      }
      if (_pickedImage == null && productModel?.productImage == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Pick a image"),
        ));
        return false;
      }
      return true;
    }
    return false;
  }

  void clearData() {
    productModel = ProductModel();
    _pickedImage = null;
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    child: Center(
                      child: _pickedImage == null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                border: Border.all(color: Colors.black),
                                borderRadius: Global().borderRadius,
                              ),
                              height: 150,
                              width: double.infinity,
                              child: productModel?.productImage != null
                                  ? FadeInImage(
                                      placeholder: AssetImage(
                                          "images/product-placeholder.png"),
                                      image: NetworkImage(
                                          productModel.productImage),
                                      fadeOutCurve: Curves.bounceOut,
                                      fit: BoxFit.cover,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add_a_photo_outlined),
                                        SizedBox(width: 5.0),
                                        Text("Add Image"),
                                      ],
                                    ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: Global().borderRadius,
                              ),
                              child: Image.file(
                                _pickedImage,
                                fit: BoxFit.cover,
                                height: 250,
                              ),
                            ),
                    ),
                  ),
                ),
                Global().height15Box,
                TextFormField(
                  initialValue: widget.editedProduct?.productName,
                  decoration: Global().textFieldDecoration.copyWith(
                        labelText: 'Item Name',
                      ),
                  validator: (value) {
                    if (value.length < 3) {
                      return "Enter a valid name";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    productModel.productName = value;
                  },
                ),
                Global().height15Box,
                TextFormField(
                  initialValue: widget.editedProduct?.productDescription,
                  decoration: Global().textFieldDecoration.copyWith(
                        labelText: 'Item Description',
                      ),
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    productModel.productDescription = value;
                    print(productModel.productDescription);
                  },
                ),
                Global().height15Box,
                TextFormField(
                  initialValue: widget.editedProduct?.amount?.toString(),
                  decoration: Global().textFieldDecoration.copyWith(
                        labelText: 'Item Price',
                      ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    productModel.amount = double.tryParse(value);
                  },
                ),
                Global().height15Box,
                Text("Select a Course"),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[400]),
                    borderRadius: Global().borderRadius,
                  ),
                  child: DropdownButton(
                    items: courseList
                        .map((course) => DropdownMenuItem(
                              value: course,
                              child: Text(course),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        productModel.course = value;
                      });
                    },
                    hint: Text(productModel?.course ?? courseHint),
                    underline: Container(),
                    isExpanded: true,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
                Global().height15Box,
                Text("Select a Category"),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[400]),
                    borderRadius: Global().borderRadius,
                  ),
                  child: DropdownButton(
                    items: categoryList
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        productModel.category = value;
                      });
                    },
                    hint: Text(productModel?.category ?? categoryHint),
                    underline: Container(),
                    isExpanded: true,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
                Global().height15Box,
                Global().height15Box,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: AppMediaQuery(context).appWidth(50) - 30,
                      decoration: BoxDecoration(
                        borderRadius: Global().borderRadius,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: Global().borderRadius,
                            side: BorderSide(color: Colors.red)),
                        color: Colors.white,
                        textColor: Colors.red,
                        child: Text('Cancel', style: Global().buttonText),
                        onPressed: () {
                          clearData();
                        },
                      ),
                    ),
                    Container(
                        width: AppMediaQuery(context).appWidth(50) - 30,
                        decoration: BoxDecoration(
                          borderRadius: Global().borderRadius,
                        ),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text("Add", style: Global().buttonText),
                          onPressed: () {
                            saveProduct();
                          },
                        )),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
