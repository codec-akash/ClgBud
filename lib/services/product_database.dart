import 'dart:io';

import 'package:clgbud/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductDataBase with ChangeNotifier {
  final CollectionReference prodCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference dropCollection =
      FirebaseFirestore.instance.collection('dropdown');

  List<ProductModel> _products = [];
  List<String> _category = [];
  List<String> _courses = [];

  List<String> get course => _courses;
  List<String> get category => _category;

  Stream<List<ProductModel>> get allProducts {
    return prodCollection.snapshots().map((event) => _productList(event));
  }

  List<ProductModel> _productList(QuerySnapshot snapshot) {
    return snapshot.docs.map((product) {
      return ProductModel.fromJson(product.data());
    }).toList();
  }

  Future addProduct(
      {ProductModel productModel, File productImage, String userId}) async {
    print("Reached");
    String imageUrl;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_image')
          .child(userId + DateTime.now().toIso8601String() + '.jpg');

      await ref.putFile(productImage);

      imageUrl = await ref.getDownloadURL();
      productModel.productImage = imageUrl;

      DocumentReference documentReference =
          await prodCollection.add(productModel.toJson());
      print(documentReference.id);
      if (documentReference.id != null) {
        productModel.productId = documentReference.id;

        _products.add(productModel);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ProductModel>> userProducts(String userID) async {
    List<ProductModel> userProduct = [];
    try {
      QuerySnapshot querySnapshot =
          await prodCollection.where("user_id", isEqualTo: userID).get();
      userProduct = querySnapshot.docs.map((e) {
        return ProductModel.fromJson(e.data());
      }).toList();
    } catch (e) {
      print(e);
    }
    return userProduct;
  }

  void getDropDowns() async {
    if (_courses.isEmpty) {
      print("dropdown received");
      DocumentSnapshot categorySnapshot =
          await dropCollection.doc('category').get();
      DocumentSnapshot courseSnapshot =
          await dropCollection.doc('course').get();
      _category = categorySnapshot.data()['name'].cast<String>();
      _courses = courseSnapshot.data()['name'].cast<String>();
    }
  }
}
