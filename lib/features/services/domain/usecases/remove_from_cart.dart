import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class RemoveFromCart {
  final ServiceRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String userId, String serviceName, String itemName) async {
    if (itemName.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.removeFromCart(userId,serviceName,itemName);
  }
}