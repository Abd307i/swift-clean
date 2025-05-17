import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../../domain/entites/service_entity.dart';

class CartModel {
  final String id;
  final String name;
  final String description;
  final DateTime addedAt;
  final double price;
  final String serviceId;

  CartModel({
    required this.id,
    required this.name,
    required this.description,
    required this.addedAt,
    required this.serviceId,
    required this.price,
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      addedAt: (data['addedAt'] as Timestamp).toDate(),
      serviceId: data['serviceId'],
      price: data['price']
    );
  }

  ItemEntity toEntity() => ItemEntity(
    id: id,
    name: name,
    description: description,
    serviceId: serviceId,
    price: price,
  );
}