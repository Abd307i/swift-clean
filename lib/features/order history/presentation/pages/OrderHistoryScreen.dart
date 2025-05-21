import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';
import 'package:testing_firebase/features/order%20history/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_bloc.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_event.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_state.dart';
import '../../../../core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/order%20history/presentation/widgets/BuildOrderListWidget.dart';
import 'package:testing_firebase/features/order%20history/presentation/widgets/BuildTabWidget.dart';
import 'OrderHistoryModel.dart';
import '../../dependency_injection.dart' as di;

class OrderHistoryScreen extends StatelessWidget {
  final String userId;
  const OrderHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return OrderHistoryBloc(
            getOrderHistory: di.sl<GetOrderHistory>())..add(GetOrderHistoryEvent(userId));
      },
      child: Scaffold(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        appBar: AppBar(
          backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
          elevation: 0,
          title: Text(
            'Order History',
            style: TextStyle(
              color: ColorPickerHelper.colorHelper('mainTextColor'),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: ColorPickerHelper.colorHelper('mainTextColor'),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: OrderHistoryScreenState(userId),
      )
    );
  }


}

class OrderHistoryScreenState extends StatelessWidget{

  final String userId;
  OrderHistoryScreenState(this.userId);

  final List<OrderHistoryModel> orders = [];
  static int selectedTab = 0;

  List<OrderHistoryEntity> getFilteredOrders(List<OrderHistoryEntity> orders) {
    switch (selectedTab) {
      case 1:
        return orders.where((order) => order.status == 'In Progress').toList();
      case 2:
        return orders.where((order) => order.status == 'Delivered').toList();
      case 3:
        return orders.where((order) => order.status == 'Canceled').toList();
      default:
        return orders;
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<OrderHistoryBloc,OrderHistoryState>(
      listener: (context,state){
        if (state is OrderHistoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          print(state.message);
        }
      },
      builder: (context, state){
        if(state is OrderHistoryLoading){
          return const Center(child: CircularProgressIndicator());
        } else if(state is OrderHistoryLoaded){
          return Column(
            children: [
              BuildTabBar(
                onTabChanged:(x){
                  selectedTab = x;
                  context.read<OrderHistoryBloc>().add(GetOrderHistoryEvent(userId));
                },
                currentTab: selectedTab,
              ),
              Expanded(
                child: BuildOrderList(getFilteredOrders(state.orders)),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}