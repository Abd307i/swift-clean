import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';

abstract class ServiceRepository{
  Future<List<ServiceEntity>> getServices();
  Future<void> addToCart(String userId, String serviceName, String itemName, double subPrice, int count);
  Future<void> removeFromCart(String userId, String serviceName, String itemName);
  Stream<List<ServiceEntity>> streamServices();
  Future<List<ItemEntity>> getCartItems(String userId);
  Future<List<ItemEntity>> getItemsByService(String serviceId);

}