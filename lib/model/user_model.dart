class UserModel {
  String username;
  String phoneNumber;
  String userId;
  String rollno;
  bool isUserComplete;

  UserModel({
    this.phoneNumber,
    this.userId,
    this.rollno,
    this.isUserComplete,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    rollno = json['roll_no'];
    phoneNumber = json['phone_number'];
    isUserComplete = json['isComplete'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['user_id'] = this.userId;
    data['roll_no'] = this.rollno;
    data['isComplete'] = this.isUserComplete;
    return data;
  }
}
