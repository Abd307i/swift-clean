import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../../domain/entites/service_entity.dart';

class CartModel {
  final List<ItemEntity> items;
  final double totalPrice;

  CartModel({
    required this.items,
    required this.totalPrice
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      items: data['items'],
      totalPrice: data['totalPrice']
    );
  }

}