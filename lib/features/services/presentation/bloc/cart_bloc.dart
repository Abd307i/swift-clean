import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/get_cart_totalprice.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final GetCartItems getCartItems;
  final GetCartTotalPrice getCartTotalPrice;

  CartBloc({
    required this.addToCart,
    required this.removeFromCart,
    required this.getCartItems,
    required this.getCartTotalPrice,

  }) : super(CartInitial()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<LoadCartItems>(_onLoadCartItems);
    on<GetCartTotalPriceEvent>(_onGetCartTotalPrice);

  }

  Future <void> _onGetCartTotalPrice(
      GetCartTotalPriceEvent event,
      Emitter <CartState> emit
      ) async{
    emit(CartTotalPriceLoading());
    try{
      final totalPrice = await getCartTotalPrice(event.userId);
      emit(CartTotalPriceLoaded(totalPrice));
    } catch (e) {
      emit(CartError('Failed to add item to cart'));
    }
  }

  Future<void> _onAddItemToCart(
      AddItemToCart event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      await addToCart(event.userId, event.serviceId, event.itemId, event.itemName, event.subPrice);
      final items = await getCartItems(event.userId);
      final totalPrice = await getCartTotalPrice(event.userId);
      emit(CartLoaded(items, totalPrice ));

      // call service
      add(LoadCartItems(event.userId));

    } catch (e) {
      emit(CartError('Failed to add item to cart'));
    }
  }

  Future<void> _onRemoveItemFromCart(
      RemoveItemFromCart event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      await removeFromCart(event.userId, event.serviceId, event.itemName);
      final items = await getCartItems(event.userId);

      final totalPrice = await getCartTotalPrice(event.userId);
      emit(CartLoaded(items, totalPrice ));
    } catch (e) {
      emit(CartError('Failed to remove item from cart'));
    }
  }

  Future<void> _onLoadCartItems(
      LoadCartItems event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      final items = await getCartItems(event.userId);
      final totalPrice = await getCartTotalPrice(event.userId);
      emit(CartLoaded(items,totalPrice));
    } catch (e) {
      emit(CartError('Failed to load cart items'));
    }
  }
}