
import '../entities/order_history.dart';

abstract class OrderHistoryRepository{
  Future <List<OrderHistoryEntity>> getOrderHistory(String userId);
  Future<List<OrderHistoryEntity>> getOrdersByStatus(String userType,String userId,String status);
}