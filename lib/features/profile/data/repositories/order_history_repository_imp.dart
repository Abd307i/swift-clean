import 'package:testing_firebase/features/profile/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/profile/domain/repositories/order_history_repository.dart';

class OrderHistoryRepositoryImp extends OrderHistoryRepository{

  @override
  Future<List<OrderHistoryItem>> getOrderHistory(String userId) {
    // TODO: implement getOrderHistory
    throw UnimplementedError();
  }

}