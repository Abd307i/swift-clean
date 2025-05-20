import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class RemoveFromCart {
  final ServiceRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String userId, String serviceId, String itemName) async {
    await repository.removeFromCart(userId,serviceId,itemName);
  }
}