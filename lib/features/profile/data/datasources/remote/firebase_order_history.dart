import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/profile/data/models/order_history_model.dart';


class FirebaseOrderHistory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get order history for a customer
  Future<List<OrderHistoryModel>> getOrderHistory(String userId) async {
    try {
      // Get reference to the user document
      DocumentReference userRef = _firestore.collection('users').doc(userId);
      
      // Query orders collection for this customer
      QuerySnapshot orderSnapshot = await _firestore.collection('orders')
          .where('customerId', isEqualTo: userRef)
          .orderBy('createdAt', descending: true)
          .get();
      
      // Convert Firestore documents to OrderHistoryModel objects
      return orderSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        // Extract items from Firestore data
        List<dynamic> orderItems = (data['items'] as List).map((item) {
          return {
            'name': item['itemType'],
            'price': item['subPrice'],
            'serviceType': item['serviceType'],
            'quantity': item['count']
          };
        }).toList();
        
        // Create OrderHistoryModel
        return OrderHistoryModel(
          id: doc.id,
          date: (data['createdAt'] as Timestamp).toDate(),
          total: data['totalPrice'].toDouble(),
          status: data['status'],
          items: orderItems
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch order history: $e');
    }
  }
    // Get order details by ID
  Future<OrderHistoryModel> getOrderDetails(String orderId) async {
    try {
      DocumentSnapshot orderDoc = await _firestore.collection('orders').doc(orderId).get();
      
      if (!orderDoc.exists) {
        throw Exception('Order not found');
      }
      
      Map<String, dynamic> data = orderDoc.data() as Map<String, dynamic>;
      
      // Extract items from Firestore data
      List<dynamic> orderItems = (data['items'] as List).map((item) {
        return {
          'name': item['itemType'],
          'price': item['subPrice'],
          'serviceType': item['serviceType'],
          'quantity': item['count']
        };
      }).toList();
      
      return OrderHistoryModel(
        id: orderDoc.id,
        date: (data['createdAt'] as Timestamp).toDate(),
        total: data['totalPrice'].toDouble(),
        status: data['status'],
        items: orderItems
      );
    } catch (e) {
      throw Exception('Failed to fetch order details: $e');
    }
  }

}