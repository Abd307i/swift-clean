import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class GetCartItems {
  final ServiceRepository repository;

  GetCartItems(this.repository);

  Future<List<ItemEntity>> call(String userId) async {
    return await repository.getCartItems(userId);
  }
}