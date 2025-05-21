

import 'package:equatable/equatable.dart';

import 'order_history_item.dart';

class OrderHistoryEntity extends Equatable{
  final String orderId;
  final String customerId;
  final String? deliveryId;
  final String? instructions;
  final DateTime? createdAt;
  final DateTime? deliveryTime;
  final List<OrderHistoryItemEntity> items;
  final String? shopId;
  final String status;
  final double totalPrice;
  final DateTime? lastUpdate;

  const OrderHistoryEntity({
    required this.orderId,
    required this.customerId,
    required this.items,
    required this.status,
    required this.totalPrice,
    this.instructions,
    this.deliveryId,
    this.createdAt,
    this.deliveryTime,
    this.shopId,
    this.lastUpdate
  });

  @override
  List<Object?> get props => [orderId, customerId, items, status, totalPrice, instructions, deliveryId, createdAt, deliveryTime,shopId,lastUpdate];
}