import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

abstract class OrderHistoryState{}

class OrderHistoryInitialState extends OrderHistoryState{}

class OrderHistoryErrorState extends OrderHistoryState{
  final String message;
  OrderHistoryErrorState(this.message);
}

class OrderHistoryLoading extends OrderHistoryState{}

class OrderHistoryLoaded extends OrderHistoryState{
  final List<OrderHistoryEntity> orders;
  OrderHistoryLoaded(this.orders);
}
