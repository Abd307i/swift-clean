import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/data/models/item_model.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';

import '../../../domain/entites/item_entity.dart';
import '../../models/service_model.dart';

class FirebaseServiceDataSourceImp {
  final FirebaseFirestore _firestore;

  FirebaseServiceDataSourceImp(this._firestore);

  Future<List<ServiceModel>> getServices() async {
    final snapshot = await _firestore.collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
  }

  Future<List<ItemEntity>> getItemsByService(String serviceId) async{
    final doc = await _firestore.collection('services').doc(serviceId).get();
    if(doc.exists){
      final data = doc.data();
      final List<dynamic> items = data?['items'] ?? [];
      return items.map((item) => ItemModel.fromJson(item).toItemEntity()).toList();
    }else{
      return [];
    }
  }

  Stream<List<ServiceModel>> streamServices(){
    return _firestore.collection('services').snapshots().map((snapshot) =>
    snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList());
  }

  Future<void> addToCart(String userId, String serviceName, String itemName, double subPrice, int count)
  async{

    final cartRef = await _firestore.collection('users/$userId/cart').doc(serviceName);
    final doc = await cartRef.get();

    if(doc.exists) {

      final data = doc.data() as Map<String, dynamic>;
      final List<Map<String, dynamic>> items = List.from(data['items'] ?? []);

      items.add({
        'id':'${items.length}',
        'count': count,
        'description':'',
        'imgUrl':'',
        'itemName': itemName,
        'subPrice': subPrice,
      });

      double totalPrice = items.fold(0, (sum, item) => sum + (item['subPrice'] * item['count']));

      cartRef.update({
        'items': items,
        'totalPrice': totalPrice,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
    }else {
      await cartRef.set({
        'items': [{
          'count': count,
          'itemName': itemName,
          'subPrice': subPrice,
        }],
        'totalPrice': subPrice * count,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // TODO
  // Implement this function
  Future<void> removeFromCart(String userId, String serviceName,String itemName) async {
    final cartRef = _firestore.collection('users/$userId/cart').doc(serviceName);
    final doc = await cartRef.get();

    if (!doc.exists) {
      return;
    }
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic> items = List.from(data['items'] ?? []);
    double totalPrice = data['totalPrice'] ?? 0.0;

    // Find the first matching item
    bool itemFound = false;
    for (int i = 0; i < items.length; i++) {
      final item = items[i] as Map<String, dynamic>;
      if (item['itemName'] == itemName) {
        // Subtract this item's contribution from total price
        totalPrice -= (item['subPrice'] ?? 0.0) * (item['count'] ?? 1);
        items.removeAt(i);
        itemFound = true;
        break; // Remove just one instance
      }
    }

    if (!itemFound) {
      return;
    }

    await cartRef.update({
      'items': items,
      'totalPrice': totalPrice,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }


  Future<List<ItemModel>> getCartItems(String userId) async {
    try {
      final querySnapshot = await _firestore.collection('users/$userId/cart')
          .get();

      return querySnapshot.docs
          .expand((doc) {
        final items = doc.data()['items'] as List? ?? [];
        return items.whereType<Map<String, dynamic>>();
      })
          .map((itemData) => ItemModel.fromJson(itemData))
          .toList();
    }catch(e){
      print(userId + '  ..  ' + e.toString());
      throw e.toString();
    }
  }

}