import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_from_cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final GetCartItems getCartItems;

  CartBloc({
    required this.addToCart,
    required this.removeFromCart,
    required this.getCartItems,
  }) : super(CartInitial()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<LoadCartItems>(_onLoadCartItems);
  }

  Future<void> _onAddItemToCart(
      AddItemToCart event,
      Emitter<CartState> emit,
      ) async {
    emit(CartLoading());
    try {
      await addToCart(event.service);
      final items = await getCartItems();
      emit(CartLoaded(items));
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
      await removeFromCart(event.serviceId);
      final items = await getCartItems();
      emit(CartLoaded(items));
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
      final items = await getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError('Failed to load cart items'));
    }
  }
}