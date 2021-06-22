import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel with ChangeNotifier {
  String productId;
  String productName;
  String productDescription;
  String category;
  String course;
  // String subject;
  String userId;
  String productImage;
  String addedDate;
  double amount;
  bool isSold;
  bool isWishlisted;

  ProductModel({
    this.productId,
    this.productName,
    this.productDescription,
    this.category,
    this.course,
    this.userId,
    this.amount,
    this.productImage,
    this.addedDate,
    this.isSold,
    this.isWishlisted,
  });

  final CollectionReference wishCollection =
      FirebaseFirestore.instance.collection('wishlist');

  final CollectionReference interestCollection =
      FirebaseFirestore.instance.collection('interested');

  List<String> wishListArray = [];
  List<String> interestedUserIds = [];

  List<String> get wishListedItems => wishListArray;

  void _setWishList(bool newValue) {
    isWishlisted = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String userID) async {
    final oldStatus = isWishlisted;
    isWishlisted = !isWishlisted;

    notifyListeners();
    try {
      wishCollection.doc(userID).get().then((value) {
        if (value.data() != null) {
          wishListArray = value['wishItem'].cast<String>();
          if (wishListArray.contains(productId)) {
            wishListArray.remove(productId);
          } else {
            wishListArray.add(productId);
          }
        } else {
          wishListArray.add(productId);
        }
        wishCollection.doc(userID).set({"wishItem": wishListArray});
        interestCollection.doc(productId).get().then((value) {
          if (value.data() != null) {
            interestedUserIds = value['userIds'].cast<String>();
            if (interestedUserIds.contains(userID)) {
              interestedUserIds.remove(userID);
            } else {
              interestedUserIds.add(userID);
            }
          } else {
            interestedUserIds.add(userID);
          }
          interestCollection.doc(productId).set({"userIds": interestedUserIds});
        });
      });
    } catch (e) {
      _setWishList(oldStatus);
      throw e;
    }
  }

  Stream<List<String>> get interestedPeople {
    return interestCollection.doc(productId).snapshots().map((event) {
      if (event.data() != null) {
        interestedUserIds = event['userIds'].cast<String>();
        return interestedUserIds;
      } else {
        return [];
      }
    });
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['description'];
    userId = json['user_id'];
    course = json['course'];
    category = json['category'];
    amount = double.parse(json['amount'].toString());
    productImage = json['product_image'];
    addedDate = json['added_date'];
    isSold = json['isSold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['description'] = this.productDescription;
    data['user_id'] = this.userId;
    data['course'] = this.course;
    data['category'] = this.category;
    // data['subject'] = this.subject;
    data['amount'] = this.amount;
    data['product_image'] = this.productImage;
    data['added_date'] = this.addedDate;
    data['isSold'] = this.isSold;
    return data;
  }
}
