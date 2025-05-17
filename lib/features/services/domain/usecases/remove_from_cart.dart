import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class RemoveFromCart {
  final ServiceRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String serviceId, String itemId,) async {
    if (itemId.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.removeFromCart(serviceId,itemId);
  }
}