import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/order%20history/domain/repositories/order_history_repository.dart';

class GetOrderHistory {
  final OrderHistoryRepository repository;

  GetOrderHistory(this.repository);

  Future<List<OrderHistoryEntity>> call(String userId) async {
    return await repository.getOrderHistory(userId);
  }

  // Add method to get orders by status
  Future<List<OrderHistoryEntity>> getOrdersByStatus(
      String userType, String userId, String status) async {
    return await repository.getOrdersByStatus(userType, userId, status);
  }
}