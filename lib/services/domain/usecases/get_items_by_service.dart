import 'package:testing_firebase/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/services/domain/repositories/service_repository.dart';

class GetItemByService {
  final ServiceRepository repository;

  GetItemByService(this.repository);

  Future<List<ItemEntity>> call(String serviceId)async{
    return await repository.getItemsByService(serviceId);
  }

}