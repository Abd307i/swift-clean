import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../../domain/entites/service_entity.dart';

abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final ItemEntity item;

  AddItemToCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final String itemId;

  RemoveItemFromCart(this.itemId);
}

class LoadCartItems extends CartEvent {}