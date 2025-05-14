import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/cart_repository.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Future<List<ItemEntity>> call() async {
    return await repository.getCartItems();
  }
}