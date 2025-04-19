import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entites/service_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore;

  CartRepositoryImpl(this._firestore);

  @override
  Future<void> addToCart(ServiceEntity service) async {
    await _firestore.collection('cart').doc(service.id).set({
      'name': service.name,
      'description': service.description,
      'addedAt': FieldValue.serverTimestamp()
    });
  }

  @override
  Future<List<ServiceEntity>> getCartItems() async {
    final snapshot = await _firestore.collection('cart').get();
    return snapshot.docs
        .map((doc) => CartModel.fromFirestore(doc).toEntity())
        .toList();
  }

  @override
  Stream<List<ServiceEntity>> streamCartItems() {
    return _firestore.collection('cart').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => CartModel.fromFirestore(doc).toEntity())
            .toList());
  }

  @override
  Future<void> removeFromCart(String serviceId) async {
    await _firestore.collection('cart').doc(serviceId).delete();
  }
}