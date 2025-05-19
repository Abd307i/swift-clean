import 'package:testing_firebase/features/order%20history/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_item.dart';

class OrderHistoryModel {
  final String id;
  final DateTime date;
  final double total;
  final String status;
  final List<dynamic> items;
  final DateTime? deliveryTime; // Added for delivery scheduling
  final int itemCount; // Added from screenshot

  OrderHistoryModel({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
    this.deliveryTime,
    required this.itemCount,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      date: json['date'].toDate(), // Assuming Firestore Timestamp
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      items: json['items'],
      deliveryTime: json['deliveryTime'] != null
          ? (json['deliveryTime'] as dynamic).toDate()
          : null,
      itemCount: json['itemCount'] ?? 0,
    );
  }

  OrderHistoryItem toEntity(OrderHistoryModel model) {
    return OrderHistoryItem(
      id: model.id,
      date: model.date,
      total: model.total,
      status: model.status,
      items: model.items.map((item) => OrderItem(
            id: id,
            name: item['name'],
            price: (item['price'] as num).toDouble(),
            serviceType: item['serviceType'],
            quantity: item['quantity'],
          )).toList(),
      deliveryTime: model.deliveryTime, //OrderHistoryItem entity need to be updated
      itemCount: model.itemCount,
    );
  }
}