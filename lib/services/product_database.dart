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

  final CollectionReference wishCollection =
      FirebaseFirestore.instance.collection('wishlist');

  List<ProductModel> _products = [];
  List<String> _category = [];
  List<String> _courses = [];
  List<String> wishListedItem = [];

  List<String> get course => _courses;
  List<String> get category => _category;

  Future<void> getWishList(String userId) async {
    wishCollection.doc(userId).get().then((value) {
      if (value.data() != null) {
        wishListedItem = value['wishItem'].cast<String>();
        notifyListeners();
      }
    });
  }

  void updateWishList(String productId) {
    if (wishListedItem.contains(productId)) {
      wishListedItem.remove(productId);
    } else {
      wishListedItem.add(productId);
    }
  }

  // Stream<List<dynamic>> getWishListStream(String userId) {
  //   return wishCollection.doc(userId).snapshots().map((event) {
  //     if (event.data() != null) {
  //       print(event.data()['wishItem']);
  //       return event.data()['wishItem'];
  //     }
  //     return [];
  //   });
  // }

  Stream<List<ProductModel>> get allProducts {
    return prodCollection.snapshots().map((event) {
      _products = _productList(event);
      return _products;
    });
  }

  List<ProductModel> _productList(QuerySnapshot snapshot) {
    return snapshot.docs.map((product) {
      ProductModel serverProd = ProductModel.fromJson(product.data());
      serverProd.productId = product.id;
      serverProd.isWishlisted =
          wishListedItem == [] ? false : wishListedItem.contains(product.id);
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
    print(_products.length);
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
      _category = categorySnapshot['name'].cast<String>();
      _courses = courseSnapshot['name'].cast<String>();
      notifyListeners();
    }
  }
}
