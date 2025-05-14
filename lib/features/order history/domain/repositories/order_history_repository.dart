import 'package:testing_firebase/features/order history/domain/entities/order_history_item.dart';

abstract class OrderHistoryRepository{
  Future <List<OrderHistoryItem>> getOrderHistory(String userId);
}