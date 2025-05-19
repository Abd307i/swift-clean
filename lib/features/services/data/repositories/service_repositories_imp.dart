import 'package:testing_firebase/features/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

class ServiceRepositoryImp extends ServiceRepository{
  final FirebaseServiceDataSourceImp dataSource;
  ServiceRepositoryImp({required this.dataSource});

  @override
  Future<void> addToCart(String userId, String serviceName, String itemName, double subPrice, int count) async{
    await dataSource.addToCart(userId,serviceName,itemName,subPrice,count);
  }

  @override
  Future<List<ServiceEntity>> getServices() async{
    final services = await dataSource.getServices();
    return services.map((model) => model.toServiceEntity()).toList();
  }



  @override
  Stream<List<ServiceEntity>> streamServices() {
    return dataSource.streamServices().map((models) =>
        models.map((model) => model.toServiceEntity()).toList());
  }

  @override
  Future<List<ItemEntity>> getCartItems(String userId) async {
    try {
      final cartItems = await dataSource.getCartItems(userId);
      return cartItems.map((model) => model.toItemEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String userId, String serviceName, String itemName) async{
    try {
      if (serviceName.isEmpty) {
        throw ArgumentError('Empty Service');
      }
      await dataSource.removeFromCart(userId,serviceName,itemName);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ItemEntity>> getItemsByService(String serviceId) async {
    try{
      final items = await dataSource.getItemsByService(serviceId);
      return items;
    } catch(e){
      throw e.toString();
    }
  }
  
}