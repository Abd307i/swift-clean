abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final String userId;
  final String serviceId;
  final String itemId;

  AddItemToCart(this.userId, this.serviceId, this.itemId);
}

class RemoveItemFromCart extends CartEvent {
  final String serviceId;
  final String itemId;

  RemoveItemFromCart(this.serviceId, this.itemId);
}

class LoadCartItems extends CartEvent {}