import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class AddToCart {
  final ServiceRepository repository;

  AddToCart(this.repository);

  Future<void> call(String userId, String serviceId, String itemId) async {
    if (itemId.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.addToCart(userId,serviceId,itemId);
  }
}