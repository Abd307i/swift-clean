abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final String userId;
  final String serviceName;
  final String itemName;
  final double subPrice;
  final int count;

  AddItemToCart(this.userId, this.serviceName, this.itemName, this.subPrice, this.count);
}

class RemoveItemFromCart extends CartEvent {
  final String userId;
  final String serviceName;
  final String itemName;

  RemoveItemFromCart(this.userId, this.serviceName, this.itemName);
}

class LoadCartItems extends CartEvent {
  final String userId;
  LoadCartItems(this.userId);
}