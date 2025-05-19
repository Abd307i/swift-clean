import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class AddToCart {
  final ServiceRepository repository;

  AddToCart(this.repository);

  Future<void> call(String userId, String serviceName, String itemName, double subPrice, int count) async {
    await repository.addToCart(userId,serviceName,itemName,subPrice,count);
  }
}