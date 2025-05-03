import 'package:flutter/material.dart';
import '../../core/constants/PickColorHelper.dart';
import '../widgets/BuildOrderListWidget.dart';
import '../widgets/BuildTabWidget.dart';
import 'OrderHistoryModel.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final List<OrderHistoryModel> orders = [];
  static int selectedTab = 0;

  List<OrderHistoryModel> getFilteredOrders() {
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

  void getOrders() {
    if (orders.isEmpty) {
      orders.addAll(OrderHistoryModel.getOrders());
    }
  }

  void _handleTabChange(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return Scaffold(
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
      body: Column(
        children: [
          BuildTabBar(
            onTabChanged: _handleTabChange,
            currentTab: selectedTab,
          ),
          Expanded(
            child: BuildOrderList(getFilteredOrders()),
          ),
        ],
      ),
    );
  }
}