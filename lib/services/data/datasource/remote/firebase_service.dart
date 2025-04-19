import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/service_model.dart';

class FirebaseServiceDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceModel>> getServices() async {
    final snapshot = await _firestore.collection('services').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
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

  Future<void> removeFromCart(String serviceId) async {
    await _firestore.collection('users/current_user_id/cart').doc(serviceId).delete();
  }

  Future<List<ServiceModel>> getCartItems() async {
    final snapshot = await _firestore.collection('users/current_user_id/cart').get();
    return snapshot.docs.map((doc) => ServiceModel.fromFirestore(doc)).toList();
  }

}