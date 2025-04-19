import 'package:testing_firebase/services/domain/entites/service_entity.dart';

abstract class ServiceRepository{
  Future<List<ServiceEntity>> getServices();
  Future<void> addToCart(ServiceEntity service);
  Future<void> removeFromCart(String serviceId);
  Stream<List<ServiceEntity>> streamServices();
  Future<List<ServiceEntity>> getCartItems();

}