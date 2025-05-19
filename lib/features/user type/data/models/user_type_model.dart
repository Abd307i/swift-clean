
class UserModel {
  final String id;
  final String address;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String userType;
  final String? shopId;

  UserModel({
    required this.id,
    required this.address,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.shopId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String docId) {
    return UserModel(
      id: docId,
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['userType'] ?? 'customer',
      shopId: json['shopId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'userType': userType,
      if (shopId != null) 'shopId': shopId,
    };
  }

  
}