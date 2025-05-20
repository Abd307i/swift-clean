import 'package:testing_firebase/features/order history/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/order history/domain/repositories/order_history_repository.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';

class GetOrderHistory{
  final OrderHistoryRepository repository;

  GetOrderHistory(this.repository);

  Future<List<OrderHistoryEntity>> call(String userId) async{
    return await repository.getOrderHistory(userId);
  }

}
