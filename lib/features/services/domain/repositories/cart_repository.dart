

import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../entites/service_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(ItemEntity service);
  Future<void> removeFromCart(String itemId);
  Future<List<ItemEntity>> getCartItems();
  Stream<List<ItemEntity>> streamCartItems();
}