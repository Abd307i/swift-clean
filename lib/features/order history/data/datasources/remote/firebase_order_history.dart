import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/order%20history/data/models/order_history_model.dart';
//import 'package:testing_firebase/features/order_history/data/models/order_history_model.dart';

class FirebaseOrderHistory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderHistoryModel>> getOrdersByStatus(
      String userType, String status) async {
    QuerySnapshot querySnapshot;

    // Define valid statuses based on user type

    /*
    if user type was customer >> status will have three values : 1-in progress(the order that is being taked care of at the moment)
                                                             2-delivered(after in progress it goes to deliverd after the whole process is finished)
                                                             3-all :all orders
if user type was drycleaner>> status will have four values : 1-avaliable(orders that is avalabile to take )
                                                             2-in progress(the order that is being taked care of at the moment)
                                                             3-delivered(after in progress it goes to deliverd after the whole process is finished)
                                                             4-all :all orders

if user type was drycleaner>> status will have four values : 1-avaliable(orders that is avalabile to take )
                                                             2-in progress(the order that is being taked care of at the moment)
                                                             3-delivered(after in progress it goes to deliverd after the whole process is finished)
                                                             4-all :all orders
     */
    final validStatuses = {
      'customer': ['in progress', 'delivered', 'all'],
      'dry_cleaner': ['available', 'in progress', 'delivered', 'all'],
      'delivery': ['available', 'in progress', 'delivered', 'all'],
    };

    if (!validStatuses[userType]!.contains(status)) {
      throw ArgumentError('Invalid status for user type: $userType');
    }

    if (status == 'all') {
      querySnapshot = await _firestore.collection('orders').get();
    } else {
      querySnapshot =
          await _firestore.collection('orders').where('status', isEqualTo: status).get();
    }

    return querySnapshot.docs.map((doc) {
      return OrderHistoryModel.fromJson({
        'id': doc.id,
        'date': doc['createdAt'],
        'total': doc['totalPrice'],
        'status': doc['status'],
        'items': doc['items'] ?? [], // Assuming items are stored
        'deliveryTime': doc['deliveryTime'],
        'itemCount': doc['itemCount'] ?? 0,
      });
    }).toList();
  }
}