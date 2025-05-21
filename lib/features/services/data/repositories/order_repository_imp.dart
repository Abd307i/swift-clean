import 'package:testing_firebase/features/services/data/datasource/remote/firebase_order.dart';
import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/order_repository.dart';

class OrderRepositoryImp extends OrderRepository{

  final FirebaseOrder _datasource;

  OrderRepositoryImp(this._datasource);

  @override
  Future<void> confirmationOrder(OrderEntity order) async {
    await _datasource.confirmOrder(order);
  }

  @override
  Future<OrderEntity> getOrder(String orderId) async {
    return await _datasource.getOrder(orderId);
  }



}