import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

abstract class OrderState{}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderConfirmationLoading extends OrderState {}

class OrderConfirmationLoaded extends OrderState {}

class OrderError extends OrderState{
  final String message;

  OrderError(this.message);
}

class OrderLoaded extends OrderState {
  final OrderEntity order;
  OrderLoaded(this.order);
}