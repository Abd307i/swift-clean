import 'order_item.dart';

class OrderHistoryItem{
  final String id;
  final DateTime date;
  final double total;
  final String status;
  final bool isExpanded;
  final List<OrderItem> items;

  OrderHistoryItem({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    this.isExpanded = false,
    required this.items});

  OrderHistoryItem copyWith({
    bool? isExpanded,
}){
    return OrderHistoryItem(id: id, date: date, total: total, status: status, items: items, isExpanded: isExpanded ?? this.isExpanded);
  }
}