import 'package:testing_firebase/features/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';

import '../models/service_model.dart';

class ServiceRepositoryImp extends ServiceRepository{
  final FirebaseServiceDataSourceImp dataSource;
  ServiceRepositoryImp({required this.dataSource});

  @override
  Future<void> addToCart(ServiceEntity service) async{
    await dataSource.addToCart(service.id,
        ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,)
    );
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
  Future<List<ServiceEntity>> getCartItems() async {
    try {
      final cartItems = await dataSource.getCartItems();
      return cartItems.map((model) => model.toServiceEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String serviceId) async{
    try {
      if (serviceId.isEmpty) {
        throw ArgumentError('Empty Service');
      }
      await dataSource.removeFromCart(serviceId);
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