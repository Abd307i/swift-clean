import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class GetCartItems {
  final ServiceRepository repository;

  GetCartItems(this.repository);

  Future<List<ServiceEntity>> call() async {
    return await repository.getCartItems();
  }
}