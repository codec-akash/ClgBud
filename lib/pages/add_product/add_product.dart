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

  ProductModel productModel;

  String productName;
  String productDesc;
  String category;
  String courses;
  String courseHint = "Select a relevant course";
  String categoryHint = "Select a relevant category";
  // String subject;
  // String subjectHint = "Select a relevant Subject";

  double price;

  bool isLoading = false;

  List<String> courseList = [];
  List<String> categoryList;
  // List<String> subjectList;

  File _pickedImage;

  @override
  void didChangeDependencies() {
    courseList = Provider.of<ProductDataBase>(context, listen: false).course;
    categoryList =
        Provider.of<ProductDataBase>(context, listen: false).category;
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

  Future<void> saveProduct() async {
    productModel = ProductModel(
      productName: productName,
      amount: price,
      productDescription: productDesc,
      category: category,
      course: courses,
      // subject: subject,
      userId: Provider.of<UserDataBase>(context, listen: false).userId,
      isSold: false,
      addedDate: DateTime.now(),
    );
    if (checkValidation()) {
      try {
        setState(() {
          isLoading = true;
        });
        await Provider.of<ProductDataBase>(context, listen: false).addProduct(
            productModel: productModel,
            productImage: _pickedImage,
            userId: productModel.userId);
        // clearData();
        setState(() {
          isLoading = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Item Added"),
        ));
        FocusScope.of(context).unfocus();
        courses = null;
        category = null;
        _pickedImage = null;
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Error Occurred Try again"),
        ));
      }
    }
  }

  bool checkValidation() {
    if (_formKey.currentState.validate()) {
      if (courses == null || category == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Enter complete details"),
        ));
        return false;
      }
      if (_pickedImage == null) {
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
    _formKey.currentState.reset();
    setState(() {
      productName = null;
      productDesc = null;
      price = null;
      courses = null;
      category = null;
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
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
                                    child: Row(
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
                          productName = value;
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
                          productDesc = value;
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
                          setState(() {
                            price = double.tryParse(value);
                          });
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
                              courses = value;
                            });
                            print("$value");
                          },
                          hint: Text(courses ?? courseHint),
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
                              .map((course) => DropdownMenuItem(
                                    value: course,
                                    child: Text(course),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                            print("$value");
                          },
                          hint: Text(category ?? categoryHint),
                          underline: Container(),
                          isExpanded: true,
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                      Global().height15Box,
                      // Text("Select a Subject"),
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey[200],
                      //     border: Border.all(color: Colors.grey[400]),
                      //     borderRadius: Global().borderRadius,
                      //   ),
                      //   child: DropdownButton(
                      //     items: courseList
                      //         .map((course) => DropdownMenuItem(
                      //               value: course,
                      //               child: Text(course),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) {
                      //       setState(() {
                      //         subject = value;
                      //       });
                      //       print("$value");
                      //     },
                      //     hint: Text(subject ?? subjectHint),
                      //     underline: Container(),
                      //     isExpanded: true,
                      //     icon: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Icon(Icons.arrow_drop_down),
                      //     ),
                      //   ),
                      // ),
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
