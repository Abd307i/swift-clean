import 'package:testing_firebase/features/services/domain/entites/service_entity.dart';

import '../../domain/entites/item_entity.dart';

abstract class ServiceState{}

class ServiceInitial extends ServiceState{}

class ServiceLoading extends ServiceState{}

class ServiceLoaded extends ServiceState{
  final List<ServiceEntity> services;

  ServiceLoaded(this.services);
}

class ServiceError extends ServiceState{
  final String message;
  ServiceError(this.message);
}

class ItemsLoading extends ServiceState {
  final String serviceId;

  ItemsLoading(this.serviceId);

}

class ItemsLoaded extends ServiceState {
  final String serviceId;
  final List<ItemEntity> items;

  ItemsLoaded(this.serviceId, this.items);

}

class ItemsError extends ServiceState {
  final String message;

  ItemsError(this.message);
}
