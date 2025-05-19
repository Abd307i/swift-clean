import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/order_repository.dart';

class ConfirmOrder{
  final OrderRepository repository;

  const ConfirmOrder(this.repository);

  Future<void> call(OrderEntity order) async{
    await repository.confirmationOrder(order);
  }
}