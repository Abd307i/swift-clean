import 'package:flutter/cupertino.dart';
import 'package:testing_firebase/services/domain/entites/service_entity.dart';
import 'package:testing_firebase/services/domain/usecases/get_services.dart';

class ServiceViewModel extends ChangeNotifier{
  final GetServices getServices;
  List<ServiceEntity> _services = [];

  ServiceViewModel(this.getServices);

  List<ServiceEntity> get services => _services;

  Future<void> loadServices() async{
    try{
      _services = await getServices();
      notifyListeners();
    }catch(e){
      throw e;
    }
  }
}