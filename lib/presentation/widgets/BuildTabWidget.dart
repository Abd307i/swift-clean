import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/core/constants/PickColorHelper.dart';
import 'package:testing/presentation/screens/OrderHistoryScreen.dart';
import 'package:testing/presentation/widgets/BuildOrderListWidget.dart';

Widget BuildTabBar() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabButton('All', 0),
        _buildTabButton('In Progress', 1),
        _buildTabButton('Delivered', 2),
        _buildTabButton('Canceled', 3),

      ],
    ),
  );
}

Widget _buildTabButton(String status, int idx){
  return Container(
    color: ColorPickerHelper.colorHelper('backgroundColor'),
    child: GestureDetector(
      onDoubleTap: () {
        OrderHistoryScreen.selectedTab = idx;
      },
      child: Text(
        status,
        style: TextStyle(
          color: OrderHistoryScreen.selectedTab == idx ? Colors.blue : ColorPickerHelper.colorHelper('secondaryTextColor'),
          fontWeight: OrderHistoryScreen.selectedTab == idx ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
}