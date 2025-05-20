import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/order%20history/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_event.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState>{
  final GetOrderHistory getOrderHistory;

  OrderHistoryBloc({required this.getOrderHistory}):super(OrderHistoryInitialState()){
    on<GetOrderHistoryEvent> (_onGetOrderHistory);
  }

  Future<void> _onGetOrderHistory(
      GetOrderHistoryEvent event,
      Emitter <OrderHistoryState> emit
      ) async {
    emit(OrderHistoryLoading());
    try{
      final orders = await getOrderHistory(event.userId);
      emit(OrderHistoryLoaded(orders));
    }catch(e){
      emit(OrderHistoryErrorState(e.toString()));
    }
  }

}