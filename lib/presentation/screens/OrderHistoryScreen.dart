import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_firebase/OrderHistoryModel.dart';
import 'package:testing_firebase/presentation/widgets/BuildTabWidget.dart';

import '../../core/constants/PickColorHelper.dart';
import '../widgets/BuildOrderListWidget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  static int selectedTab = 0;

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();

}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final List<OrderHistoryModel> orders = [];

  final List<OrderHistoryModel> newOrders = [];

  List<OrderHistoryModel> getNewOrders(){
    switch (OrderHistoryScreen.selectedTab) {
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

  void getOrders(){
    orders.addAll(OrderHistoryModel.getOrders());
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return Scaffold(
      backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      appBar: AppBar(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        title: Text('Order History',
            style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorPickerHelper.colorHelper('mainTextColor'),),
          onPressed:() {
            Navigator.pop(context);
          },),
      ),
      body: Column(
        children: [
          BuildTabBar(),
          Expanded(
            child: BuildOrderList(getNewOrders()),
          ),
        ],
      ),
    );
  }
}
