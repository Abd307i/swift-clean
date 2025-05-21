import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/data/models/item_model.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';
import '../../../domain/entites/item_entity.dart';
import '../../models/service_model.dart';

class FirebaseServiceDataSourceImp {
  final FirebaseFirestore _firestore;

  FirebaseServiceDataSourceImp(this._firestore);

  Future<void> addToCart(
      String userId,
      String serviceId, // Added service ID parameter
      String itemId,
      String itemName,
      double subPrice,
      ) async {
    final cartRef = _firestore.collection('users').doc(userId).collection('cart').doc('user_cart');

    return _firestore.runTransaction((transaction) async {
      final doc = await transaction.get(cartRef);

      if (!doc.exists) {
        // Create new cart with this item
        transaction.set(cartRef, {
          'items': [{
            'id': itemId,
            'serviceId': serviceId, // Store service reference
            'count': 1,
            'itemName': itemName,
            'subPrice': subPrice,
            'itemId':'a'
          }],
          'totalPrice': subPrice,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        return;
      }

      final data = doc.data()!;
      final List<dynamic> items = List.from(data['items'] ?? []);
      double totalPrice = data['totalPrice'] ?? 0.0;

      // Check if item already exists in the same service
      bool itemExists = false;
      for (int i = 0; i < items.length; i++) {
        final item = items[i] as Map<String, dynamic>;
        if (item['id'] == itemId && item['serviceId'] == serviceId) {
          // Increment count for same item in same service
          items[i]['count'] = (item['count'] ?? 0) + 1;
          totalPrice += subPrice;
          itemExists = true;
          break;
        }
      }

      if (!itemExists) {
        // Add new item with service reference
        items.add({
          'id': itemId,
          'serviceId': serviceId,
        'itemId':itemId??'',
          'count': 1,
          'itemName': itemName,
          'subPrice': subPrice,
          'description':'',
          'imgUrl':''
        });
        totalPrice += subPrice;
      }

      transaction.update(cartRef, {
        'items': items,
        'totalPrice': totalPrice,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> removeFromCart(String userId, String serviceId, String itemName) async {
    try{
      final cartRef = _firestore.collection('users').doc(userId).collection('cart').doc('user_cart');

      return _firestore.runTransaction((transaction) async {

        final doc = await transaction.get(cartRef);

        if (!doc.exists) {
          return;
        }

        final data = doc.data()!;
        final List<dynamic> items = List.from(data['items'] ?? []);
        double totalPrice = data['totalPrice'] ?? 0.0;

        for (int i = 0; i < items.length; i++) {
          final item = items[i] as Map<String, dynamic>;
          if (item['itemName'] == itemName && item['serviceId'] == serviceId) {
            final int currentCount = item['count'] ?? 1;
            final double itemPrice = item['subPrice'] ?? 0.0;

            if (currentCount > 1) {
              // Decrement count
              items[i]['count'] = currentCount - 1;
              totalPrice -= itemPrice;
            } else {
              // Remove item completely
              items.removeAt(i);
              totalPrice -= itemPrice;
            }

            transaction.update(cartRef, {
              'items': items,
              'totalPrice': totalPrice,
              'updatedAt': FieldValue.serverTimestamp(),
            });
            return;
          }
        }
      });
    }catch(e){
      print(e.toString());
    }

  }

  Future<List<ItemModel>> getCartItemsByService(String userId, String serviceId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('user_cart')
          .get();

      if (!doc.exists) {
        return [];
      }

      final items = doc.data()?['items'] as List? ?? [];
      return items
          .whereType<Map<String, dynamic>>()
          .where((item) => item['serviceId'] == serviceId) // Filter by service
          .map((itemData) => ItemModel.fromJson(itemData))
          .toList();
    } catch (e) {
      print('Error getting cart items by service: $e');
      rethrow;
    }
  }

  Future<List<ItemModel>> getCartItems(String userId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc('user_cart')
          .get();

      if (!doc.exists) {
        return [];
      }

      final items = doc.data()?['items'] as List? ?? [];
      return items
          .whereType<Map<String, dynamic>>()
          .map((itemData) => ItemModel.fromJson(itemData))
          .toList();
    } catch (e) {
      print('Error getting cart items: $e');
      rethrow;
    }
  }

  Future<double> getCartTotalPrice(String userId) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc('user_cart')
        .get();

    if (!doc.exists) {
      return 0.0;
    }

    return (doc.data()?['totalPrice'] ?? 0.0).toDouble();
  }

  Future<List<ServiceModel>> getServices() async {
    final snapshot = await _firestore.collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
  }

  Future<List<ItemEntity>> getItemsByService(String serviceId) async {
    final doc = await _firestore.collection('services').doc(serviceId).get();
    if (doc.exists) {
      final data = doc.data();
      final List<dynamic> items = data?['items'] ?? [];
      return items.map((item) => ItemModel.fromJson(item).toItemEntity()).toList();
    } else {
      return [];
    }
  }

  Stream<List<ServiceModel>> streamServices() {
    return _firestore.collection('services').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList());
  }
// [Other methods remain unchanged...]
}