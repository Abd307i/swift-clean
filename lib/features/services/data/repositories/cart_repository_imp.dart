import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../../domain/entites/service_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore firestore;

  CartRepositoryImpl({required this.firestore});

  @override
  Future<void> addToCart(ItemEntity item) async {
    await firestore.collection('cart').doc(item.id).set({
      'name': item.name,
      'description': item.description,
      'addedAt': FieldValue.serverTimestamp()
    });
  }

  @override
  Future<List<ItemEntity>> getCartItems() async {
    final snapshot = await firestore.collection('cart').get();
    return snapshot.docs
        .map((doc) => CartModel.fromFirestore(doc).toEntity())
        .toList();
  }

  @override
  Stream<List<ItemEntity>> streamCartItems() {
    return firestore.collection('cart').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => CartModel.fromFirestore(doc).toEntity())
            .toList());
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    await firestore.collection('cart').doc(itemId).delete();
  }
}