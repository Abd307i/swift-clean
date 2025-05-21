import 'package:testing_firebase/features/order%20history/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history_item.dart';

import '../../domain/repositories/order_history_repository.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final FirebaseOrderHistory _dataSource;

  OrderHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<OrderHistoryEntity>> getOrdersByStatus(
      String userType, String userId, String status) async {
    try {
      final models = await _dataSource.getOrdersByStatus(userType,userId,status);
      return models;
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<List<OrderHistoryEntity>> getOrderHistory(String userId) async {
    try {
      final orders = await _dataSource.getOrderHistory(userId);
      return orders;
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }
}
