class ProductModel {
  String productId;
  String productName;
  String productDescription;
  String category;
  String course;
  String subject;
  String userId;
  String productImage;
  double amount;
  bool isSold;

  ProductModel({
    this.productId,
    this.productName,
    this.productDescription,
    this.category,
    this.course,
    this.subject,
    this.userId,
    this.amount,
    this.isSold,
    this.productImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['description'];
    userId = json['user_id'];
    course = json['course'];
    category = json['category'];
    subject = json['subject'];
    isSold = json['isSold'];
    amount = json['amount'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['description'] = this.productDescription;
    data['user_id'] = this.userId;
    data['course'] = this.course;
    data['category'] = this.category;
    data['subject'] = this.subject;
    data['isSold'] = this.isSold;
    data['amount'] = this.amount;
    data['product_image'] = this.productImage;
    return data;
  }
}