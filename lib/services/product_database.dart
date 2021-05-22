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
      ProductModel serverProd = ProductModel.fromJson(product.data());
      serverProd.productId = product.id;
      return serverProd;
    }).toList();
  }

  Future addProduct({ProductModel productModel, File productImage}) async {
    String imageUrl;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_image')
          .child(productModel.userId + productModel.addedDate + '.jpg');

      await ref.putFile(productImage);

      imageUrl = await ref.getDownloadURL();
      productModel.productImage = imageUrl;

      DocumentReference documentReference =
          await prodCollection.add(productModel.toJson());
      print(documentReference.id);
      if (documentReference.id != null) {
        productModel.productId = documentReference.id;
        print(productModel.productId);
        _products.add(productModel);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updateProduct(ProductModel productModel, File productImage) async {
    print("Update  ${productModel.productId}");
    final prodIndex = _products
        .indexWhere((prod) => prod.productId == productModel.productId);
    print(prodIndex);
    try {
      String imageUrl;
      if (productImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('product_image')
            .child(productModel.userId + productModel.addedDate + '.jpg');
        await ref.putFile(productImage);

        imageUrl = await ref.getDownloadURL();
        productModel.productImage = imageUrl;
      }
      await prodCollection
          .doc(productModel.productId)
          .set(productModel.toJson());

      _products[prodIndex] = productModel;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    notifyListeners();
  }

  Future deleteProduct(String productID) async {
    try {
      await prodCollection.doc(productID).delete();
      _products.removeWhere((element) => element.productId == productID);
    } catch (e) {
      throw e;
    }
  }

  Stream<List<ProductModel>> userProd(String userID) {
    return prodCollection
        .where("user_id", isEqualTo: userID)
        .snapshots()
        .map((userPro) => _productList(userPro));
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
      notifyListeners();
    }
  }
}
