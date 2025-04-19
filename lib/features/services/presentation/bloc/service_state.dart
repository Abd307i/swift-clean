import 'package:testing_firebase/services/domain/entites/service_entity.dart';

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

