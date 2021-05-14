import 'dart:io';

import 'package:clgbud/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductDataBase with ChangeNotifier {
  final CollectionReference prodCollection =
      FirebaseFirestore.instance.collection('products');

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

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
}
