import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

class OrderModel extends OrderEntity{

  const OrderModel({
    required super.orderId,
    required super.customerId,
    required super.items,
    required super.status,
    required super.totalPrice,
    super.instructions,
    super.deliveryId,
    super.createdAt,
    super.deliveryTime,
    super.shopId,
    super.lastUpdate
  });

  factory OrderModel.fromJson(Map<String,  dynamic> json){
    return OrderModel(
        orderId: json['orderId'],
        customerId: json['customerId'],
        items: json['items'],
        status: json['status'],
        totalPrice: json['totalPrice'],
        instructions: json['instructions'],
        deliveryId: json['deliveryId'],
        createdAt: json['createdAt'],
        deliveryTime: json['deliveryTime'],
        shopId: json['shopId'],
        lastUpdate: json['lastUpdate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'customerId': customerId,
    'items':items,
    'status':status,
    'totalPrice':totalPrice,
    'instructions':instructions,
    'deliveryId':deliveryId,
    'createdAt':createdAt,
    'deliveryTime':deliveryTime,
    'shopId':shopId,
    'lastUpdate':lastUpdate,
  };

  factory OrderModel.fromEntity(OrderEntity order){
    return OrderModel(
        orderId: order.orderId,
        customerId: order.customerId,
        items: order.items,
        status: order.status,
        totalPrice: order.totalPrice,
        instructions: order.instructions,
        deliveryId: order.deliveryId,
        createdAt: order.createdAt,
        deliveryTime: order.deliveryTime,
        shopId: order.shopId,
        lastUpdate: order.lastUpdate
    );
  }

}