
import '../entites/service_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(ServiceEntity service);
  Future<void> removeFromCart(String serviceId);
  Future<List<ServiceEntity>> getCartItems();
  Stream<List<ServiceEntity>> streamCartItems();
}