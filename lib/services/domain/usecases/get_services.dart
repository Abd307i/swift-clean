import 'package:testing_firebase/services/domain/entites/service_entity.dart';
import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

class GetServices{
  final ServiceRepository repository;

  GetServices(this.repository);

  Future <List<ServiceEntity>> call() async{
    return await repository.getServices();
  }
}