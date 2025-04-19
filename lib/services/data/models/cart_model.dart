import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/service_entity.dart';

class CartModel {
  final String id;
  final String name;
  final String description;
  final DateTime addedAt;

  CartModel({
    required this.id,
    required this.name,
    required this.description,
    required this.addedAt,
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      addedAt: (data['addedAt'] as Timestamp).toDate(),
    );
  }

  ServiceEntity toEntity() => ServiceEntity(
    id: id,
    name: name,
    description: description,
  );
}