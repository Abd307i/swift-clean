import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/order history/data/models/order_history_model.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';

import '../../../domain/entities/order_history_item.dart';


class FirebaseOrderHistory {
  final FirebaseFirestore _firestore;

  FirebaseOrderHistory(this._firestore);

  // Get order history for a customer
  Future<List<OrderHistoryEntity>> getOrderHistory(String userId) async {
    try {
      final QuerySnapshot orderSnapshot = await _firestore
          .collection('Orders')
          .where('customerId', isEqualTo: userId)
         // .orderBy('createdAt', descending: true)
          .get();

      return orderSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Convert items with proper typing
        final List<OrderHistoryItemEntity> orderItems = (data['items'] as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((item) => OrderHistoryItemEntity(
          id: item['id'] as String? ?? '',
          itemName: item['itemType'] as String? ?? 'Unknown',
          subPrice: (item['subPrice'] as double?)?.toDouble() ?? 0.0,
          imgUrl: item['imgUrl'] as String?,
          description: item['description'] as String?,
        ))
            .toList();

        // Handle Timestamp conversions
        final createdAt = data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : null;
        final deliveryTime = data['deliveryTime'] != null
            ? (data['deliveryTime'] as Timestamp).toDate()
            : null;
        final lastUpdate = data['lastUpdate'] != null
            ? (data['lastUpdate'] as Timestamp).toDate()
            : null;

        return OrderHistoryEntity(
          orderId: doc.id,
          customerId: data['customerId'] as String? ?? userId,
          items: orderItems,
          status: data['status'] as String? ?? 'unknown',
          totalPrice: (data['totalPrice'] as double?)?.toDouble() ?? 0.0,
          instructions: data['instructions'] as String?,
          deliveryId: data['deliveryId'] as String?,
          createdAt: createdAt,
          deliveryTime: deliveryTime,
          shopId: data['shopId'] as String?,
          lastUpdate: lastUpdate,
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data format error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching order history: $e');
    }
  }
    // Get order details by ID
  Future<OrderHistoryModel> getOrderDetails(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw ArgumentError('Order ID cannot be empty');
      }

      final DocumentSnapshot orderDoc =
      await _firestore.collection('Orders').doc(orderId).get();

      if (!orderDoc.exists) {
        throw Exception('Order not found');
      }

      final data = orderDoc.data() as Map<String, dynamic>;

      // Convert items to OrderHistoryItemEntity
      final List<OrderHistoryItemEntity> orderItems = (data['items'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map((item) => OrderHistoryItemEntity(
        id: item['id'] as String? ?? '',
        itemName: item['itemType'] as String? ?? 'Unknown',
        subPrice: (item['subPrice'] as double?)?.toDouble() ?? 0.0,
        imgUrl: item['imgUrl'] as String?,
        description: item['description'] as String?,
      ))
          .toList();

      // Handle Timestamp conversions
      final createdAt = data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null;
      final deliveryTime = data['deliveryTime'] != null
          ? (data['deliveryTime'] as Timestamp).toDate()
          : null;
      final lastUpdate = data['lastUpdate'] != null
          ? (data['lastUpdate'] as Timestamp).toDate()
          : null;

      return OrderHistoryModel(
        orderId: orderDoc.id,
        customerId: data['customerId'] as String? ?? '',
        items: orderItems,
        status: data['status'] as String? ?? 'unknown',
        totalPrice: (data['totalPrice'] as double?)?.toDouble() ?? 0.0,
        instructions: data['instructions'] as String?,
        deliveryId: data['deliveryId'] as String?,
        createdAt: createdAt,
        deliveryTime: deliveryTime,
        shopId: data['shopId'] as String?,
        lastUpdate: lastUpdate,
      );
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data format error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch order details: $e');
    }
  }

  Future<List<OrderHistoryEntity>> getOrdersByStatus(String userType, String userId, String status) async{
    try {
      final QuerySnapshot orderSnapshot = await _firestore
          .collection('Orders')
          .where('customerId', isEqualTo: userId,).where('status', isEqualTo: status)
      // .orderBy('createdAt', descending: true)
          .get();

      return orderSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Convert items with proper typing
        final List<OrderHistoryItemEntity> orderItems = (data['items'] as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map((item) => OrderHistoryItemEntity(
          id: item['id'] as String? ?? '',
          itemName: item['itemType'] as String? ?? 'Unknown',
          subPrice: (item['subPrice'] as double?)?.toDouble() ?? 0.0,
          imgUrl: item['imgUrl'] as String?,
          description: item['description'] as String?,
        ))
            .toList();

        // Handle Timestamp conversions
        final createdAt = data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : null;
        final deliveryTime = data['deliveryTime'] != null
            ? (data['deliveryTime'] as Timestamp).toDate()
            : null;
        final lastUpdate = data['lastUpdate'] != null
            ? (data['lastUpdate'] as Timestamp).toDate()
            : null;

        return OrderHistoryEntity(
          orderId: doc.id,
          customerId: data['customerId'] as String? ?? userId,
          items: orderItems,
          status: data['status'] as String? ?? 'unknown',
          totalPrice: (data['totalPrice'] as double?)?.toDouble() ?? 0.0,
          instructions: data['instructions'] as String?,
          deliveryId: data['deliveryId'] as String?,
          createdAt: createdAt,
          deliveryTime: deliveryTime,
          shopId: data['shopId'] as String?,
          lastUpdate: lastUpdate,
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception('Firestore error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data format error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching order history: $e');
    }
  }

}