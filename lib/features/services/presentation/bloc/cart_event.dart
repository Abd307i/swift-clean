import '../../domain/entites/service_entity.dart';

abstract class CartEvent {}

class AddItemToCart extends CartEvent {
  final ServiceEntity service;

  AddItemToCart(this.service);
}

class RemoveItemFromCart extends CartEvent {
  final String serviceId;

  RemoveItemFromCart(this.serviceId);
}

class LoadCartItems extends CartEvent {}