import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/services/data/models/order_model.dart';
import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';

class FirebaseOrder {
  final FirebaseFirestore _firestore;

  const FirebaseOrder(this._firestore);

  Future <void> confirmOrder(OrderEntity order) async {
    try{
      print(order.items);
      await _firestore.collection('Orders').doc(order.orderId).set({
        'createdAt':Timestamp.now(),
        'customerId':order.customerId,
        'items': order.items.map((item) => {
          'itemName': item.itemName,
          'itemId': item.itemId,
          'subPrice': item.subPrice,
          'count': item.count,
          'imgUrl': item.imgUrl,
          'description': item.description,
        }).toList(),
        'status': order.status,
        'totalPrice': order.totalPrice,
        'deliveryId': order.deliveryId,
        'deliveryTime': order.deliveryTime,
        'instructions': order.instructions,
        'shopId': order.shopId,
        'lastUpdate': Timestamp.now()
      });
    }catch (e){
      print(e.toString());
      throw e.toString();
    }
  }

  Future <OrderEntity> getOrder(String orderId) async {
    try{
      final doc = await _firestore.collection('Orders').doc(orderId).get();
      return OrderModel.fromJson(doc.data()!);
    }catch (e){
      throw e.toString();
    }
  }

}