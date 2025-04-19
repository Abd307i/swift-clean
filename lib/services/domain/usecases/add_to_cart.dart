import '../entites/service_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(ServiceEntity service) async {
    if (service.id.isEmpty) {
      throw ArgumentError('Service ID cannot be empty');
    }
    await repository.addToCart(service);
  }
}