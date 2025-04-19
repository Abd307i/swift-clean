import 'package:testing_firebase/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/services/domain/entites/service_entity.dart';
import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

import '../models/service_model.dart';

class ServiceRepositoryImp extends ServiceRepository{
  final FirebaseServiceDataSource _dataSource;
  ServiceRepositoryImp(this._dataSource);

  @override
  Future<void> addToCart(ServiceEntity service) async{
    await _dataSource.addToCart(service.id,
        ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,)
    );
  }

  @override
  Future<List<ServiceEntity>> getServices() async{
    final services = await _dataSource.getServices();
    return services.map((model) => model.toEntity()).toList();
  }

  @override
  Stream<List<ServiceEntity>> streamServices() {
    return _dataSource.streamServices().map((models) =>
        models.map((model) => model.toEntity()).toList());
  }

  @override
  Future<List<ServiceEntity>> getCartItems() async {
    try {
      final cartItems = await _dataSource.getCartItems();
      return cartItems.map((model) => model.toEntity()).toList();
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
      await _dataSource.removeFromCart(serviceId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
}