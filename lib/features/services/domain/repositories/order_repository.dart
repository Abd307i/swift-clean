import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

abstract class OrderRepository{
  Future <void> confirmationOrder(OrderEntity order);
  Future <OrderEntity> getOrder(String orderId);
}