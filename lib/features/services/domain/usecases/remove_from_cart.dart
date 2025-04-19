import '../repositories/cart_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String serviceId) async {
    if (serviceId.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.removeFromCart(serviceId);
  }
}