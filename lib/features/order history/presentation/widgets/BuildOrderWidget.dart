import 'package:flutter/material.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';

import '../pages/OrderHistoryModel.dart';

Widget BuildOrderCard(OrderHistoryModel order) {
  return Card(
    color: ColorPickerHelper.colorHelper('backgroundColor'),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #${order.orderNumber}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ColorPickerHelper.colorHelper('mainTextColor')
            ),
          ),
          SizedBox(height: 8),
          Text(
            order.dateTime,
            style: TextStyle(
              color: ColorPickerHelper.colorHelper('secondaryTextColor'),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order.numberOfItems} Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    color: ColorPickerHelper.colorHelper('mainTextColor'),
                ),
              ),
              Text(
                '\$ ${order.price}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (order.status == 'In Progress')
            OutlinedButton(
              onPressed: () {
                // Track order functionality
              },
              child: Text('Track Order'),
            ),
          if (order.status == 'Delivered')
            Text(
              'Delivered',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (order.status == 'Canceled')
            Text(
              'Canceled',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    ),
  );
}