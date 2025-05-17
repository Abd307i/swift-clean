import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';

abstract class ServiceRepository{
  Future<List<ServiceEntity>> getServices();
  Future<void> addToCart(String userId, String serviceId, String itemId);
  Future<void> removeFromCart(String serviceId, String itemId);
  Stream<List<ServiceEntity>> streamServices();
  Future<List<ItemEntity>> getCartItems();
  Future<List<ItemEntity>> getItemsByService(String serviceId);

}