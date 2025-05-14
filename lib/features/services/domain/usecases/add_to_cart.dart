import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/cart_repository.dart';

import '../entites/service_entity.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(ItemEntity item) async {
    if (item.id.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.addToCart(item);
  }
}