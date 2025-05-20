import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';

import '../../domain/entites/service_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ItemEntity> items;
  final double totalPrice;

  CartLoaded(this.items, this.totalPrice);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}

class CartTotalPriceLoading extends CartState{
}


class CartTotalPriceLoaded extends CartState{
  final double totalPrice;

  CartTotalPriceLoaded(this.totalPrice);
}