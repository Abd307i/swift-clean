import 'package:testing_firebase/features/order%20history/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history_item.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final FirebaseOrderHistory _dataSource;

  OrderHistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<OrderHistoryItem>> getOrdersByStatus(
      String userType, String status) async {
    try {
      final models = await _dataSource.getOrdersByStatus(userType, status);
      return models.map((model) => model.toEntity(model)).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }
}

abstract class OrderHistoryRepository {
  Future<List<OrderHistoryItem>> getOrdersByStatus(String userType, String status);
}