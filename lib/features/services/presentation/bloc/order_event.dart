import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

abstract class OrderEvent {}

class ConfirmOrderEvent extends OrderEvent{
  final OrderEntity order;
  ConfirmOrderEvent(this.order);
}

class GetOrderEvent extends OrderEvent{
  final String orderId;
  GetOrderEvent(this.orderId);
}