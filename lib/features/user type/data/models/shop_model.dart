
class ShopModel {
  final String id;
  final String address;
  final bool isActive;
  final String location;
  final String name;
  final String ownerId;
  final String phone;
  final double rating;

  ShopModel({
    required this.id,
    required this.address,
    required this.isActive,
    required this.location,
    required this.name,
    required this.ownerId,
    required this.phone,
    required this.rating,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json, String docId) {
    return ShopModel(
      id: docId,
      address: json['address'] ?? '',
      isActive: json['isActive'] ?? false,
      location: json['location'] ?? '',
      name: json['name'] ?? '',
      ownerId: json['ownerId'] ?? '',
      phone: json['phone'] ?? '',
      rating: json['rating'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'isActive': isActive,
      'location': location,
      'name': name,
      'ownerId': ownerId,
      'phone': phone,
      'rating': rating,
    };
  }

  
}