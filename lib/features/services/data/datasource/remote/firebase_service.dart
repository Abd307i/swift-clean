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
    final snapshot = await _firestore.collection('services/$serviceId/items/').get();
    return snapshot.docs.map((doc) => ItemModel.fromJson(doc.data()).toItemEntity()).toList();
  }

  Stream<List<ServiceModel>> streamServices(){
    return _firestore.collection('services').snapshots().map((snapshot) =>
    snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList());
  }

  Future<void> addToCart(String userId, ServiceModel service) async{
    await _firestore.collection('users/$userId/cart').doc(service.id).set({
      'name':service.name,
      'description':service.description,
      'addedAt': FieldValue.serverTimestamp()
    });
  }
// TODO
  // Implement this function
  Future<void> removeFromCart(String serviceId) async {
    await _firestore.collection('users//cart').doc(serviceId).delete();
  }

  // TODO
  // Implement this function
  Future<List<ServiceModel>> getCartItems() async {
    final snapshot = await _firestore.collection('users/current_user_id/cart').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
  }

}