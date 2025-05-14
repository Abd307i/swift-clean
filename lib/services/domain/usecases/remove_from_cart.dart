import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

class RemoveFromCart {
  final ServiceRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String serviceId) async {
    if (serviceId.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.removeFromCart(serviceId);
  }
}