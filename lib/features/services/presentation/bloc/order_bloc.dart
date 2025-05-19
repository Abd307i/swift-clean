import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/services/domain/usecases/confirm_order.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_order.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_event.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  final GetOrder getOrder;
  final ConfirmOrder confirmOrder;

  OrderBloc({required this.getOrder, required this.confirmOrder})
      :super(OrderInitial()){
    on<GetOrderEvent>(_onGetOrderEvent);
    on<ConfirmOrderEvent>(_onConfirmOrderEvent);
  }

  Future <void> _onGetOrderEvent(
      GetOrderEvent event,
      Emitter<OrderState> emit
      ) async{
    emit(OrderLoading());
    try{
      final order = await getOrder(event.orderId);
      emit(OrderLoaded(order));
    }catch(e){
      emit(OrderError(e.toString()));
    }
  }

  Future <void> _onConfirmOrderEvent(
      ConfirmOrderEvent event,
      Emitter<OrderState> emit
      ) async{
    emit(OrderConfirmationLoading());
    try{
      await confirmOrder(event.order);
      emit(OrderConfirmationLoaded());
    } catch (e){
      emit(OrderError(e.toString()));
    }
  }
}