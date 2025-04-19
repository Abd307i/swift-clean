import 'package:flutter/cupertino.dart';

class OrderHistoryModel{
  int id;
  String date;
  int itemCount;
  double total;
  String status;

  OrderHistoryModel({
    required this.id,
    required this.date,
    required this.itemCount,
    required this.total,
    required this.status,
  });

  static List<OrderHistoryModel> getOrders(){
    List<OrderHistoryModel> orders = [];
    orders.add(OrderHistoryModel(
      id: 123,
      date: '13 Sep 2003 at 12:00 PM',
      itemCount: 13,
      total: 100.0,
      status: 'Delivered'
    ));
    orders.add(OrderHistoryModel(
        id: 123,
        date: '13 Sep 2003 at 12:00 PM',
        itemCount: 13,
        total: 100.0,
        status: 'Canceled'
    ));
    orders.add(OrderHistoryModel(
        id: 123,
        date: '13 Sep 2003 at 12:00 PM',
        itemCount: 13,
        total: 100.0,
        status: 'In Progress'
    ));

    return orders;
  }
}