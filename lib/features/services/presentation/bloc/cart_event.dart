abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final String userId;
  final String serviceId;
  final String itemId;
  final String itemName;
  final double subPrice;

  AddItemToCart(this.userId, this.serviceId, this.itemId, this.itemName, this.subPrice);
}

class RemoveItemFromCart extends CartEvent {
  final String userId;
  final String serviceId;
  final String itemName;

  RemoveItemFromCart(this.userId, this.serviceId, this.itemName);
}

class LoadCartItems extends CartEvent {
  final String userId;
  LoadCartItems(this.userId);
}

class GetCartTotalPriceEvent extends CartEvent{
  final String userId;
  GetCartTotalPriceEvent(this.userId);
}