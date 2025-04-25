
import 'package:testing_firebase/features/profile/domain/entities/order_history_item.dart';
import 'package:testing_firebase/features/profile/domain/entities/order_item.dart';

class OrderHistoryModel{
  final String id;
  final DateTime date;
  final double total;
  final String status;
  final List<dynamic> items;

  OrderHistoryModel({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items
});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      date: json['date'],
      total: json['total'],
      status: json['status'],
      items: json['items'],
    );
  }
  OrderHistoryItem toEntity(OrderHistoryModel model){
    return OrderHistoryItem(id: model.id,
        date: model.date, total: model.total, status: model.status,
        items: model.items.map((items) => OrderItem(
            id: id, name: items['name'],
            price: items['price'],
            serviceType: items['serviceType'],
            quantity: items['quantity']
        )).toList()
    );
  }
}