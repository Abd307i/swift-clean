import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/order_repository.dart';

class GetOrder{
  final OrderRepository repository;

  const GetOrder(this.repository);

  Future <OrderEntity> call(String orderId) async {
    return await repository.getOrder(orderId);
  }
}