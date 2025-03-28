import 'package:flutter/cupertino.dart';
import 'package:testing/OrderHistoryModel.dart';
import 'package:testing/core/constants/PickColorHelper.dart';
import 'package:testing/presentation/screens/OrderHistoryScreen.dart';

import 'BuildOrderWidget.dart';

Widget BuildOrderList(List<OrderHistoryModel> orders){
  if(orders.isEmpty){
    return Center(
      child: Text('No Orders Found', style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor')),),
    );
  }

  return ListView.builder(
    itemCount: orders.length,
    itemBuilder: (context, index) {
      final order = orders[index];
      return BuildOrderCard(order);
    },
  );
}