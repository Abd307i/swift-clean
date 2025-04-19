import '../entites/service_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Future<List<ServiceEntity>> call() async {
    return await repository.getCartItems();
  }
}