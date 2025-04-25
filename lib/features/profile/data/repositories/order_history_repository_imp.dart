import 'package:testing_firebase/features/profile/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/profile/data/models/order_history_model.dart';
import 'package:testing_firebase/features/profile/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/profile/domain/repositories/order_history_repository.dart';


class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final FirebaseOrderHistory _firebaseOrderHistory;
  
  OrderHistoryRepositoryImpl(this._firebaseOrderHistory);
  
  @override
  Future<List<OrderHistoryItem>> getOrderHistory(String userId) async {
    try {
      // Get order history models from Firebase
      List<OrderHistoryModel> orderModels = await _firebaseOrderHistory.getOrderHistory(userId);
      
      // Convert models to entities
      return orderModels.map((model) => model.toEntity(model)).toList();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
  
  @override
  // ignore: override_on_non_overriding_member
  Future<OrderHistoryItem> getOrderDetails(String orderId) async {
    try {
      OrderHistoryModel orderModel = await _firebaseOrderHistory.getOrderDetails(orderId);
      return orderModel.toEntity(orderModel);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
  
  
  
}