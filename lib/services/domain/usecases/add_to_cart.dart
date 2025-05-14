import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

import '../entites/service_entity.dart';

class AddToCart {
  final ServiceRepository repository;

  AddToCart(this.repository);

  Future<void> call(ServiceEntity service) async {
    if (service.id.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.addToCart(service);
  }
}