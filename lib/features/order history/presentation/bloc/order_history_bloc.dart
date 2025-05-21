import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/order%20history/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_event.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState>{
  final GetOrderHistory getOrderHistory;

  OrderHistoryBloc({required this.getOrderHistory}):super(OrderHistoryInitialState()){
    on<GetOrderHistoryEvent>(_onGetOrderHistory);
    on<GetOrderHistoryByUserType>(_onGetOrderHistoryByUserType); // Add handler for this event
  }

  Future<void> _onGetOrderHistory(
      GetOrderHistoryEvent event,
      Emitter<OrderHistoryState> emit
      ) async {
    emit(OrderHistoryLoading());
    try{
      final orders = await getOrderHistory(event.userId);
      emit(OrderHistoryLoaded(orders));
    } catch(e){
      emit(OrderHistoryErrorState(e.toString()));
    }
  }

  // New method to handle GetOrderHistoryByUserType event
  Future<void> _onGetOrderHistoryByUserType(
      GetOrderHistoryByUserType event,
      Emitter<OrderHistoryState> emit
      ) async {
    emit(OrderHistoryLoading());
    try {
      // Update the method to handle filtering by status as well
      final orders = await getOrderHistory.getOrdersByStatus(
          event.userType,
          event.userId,
          event.status
      );
      emit(OrderHistoryLoaded(orders));
    } catch(e) {
      emit(OrderHistoryErrorState(e.toString()));
    }
  }
}