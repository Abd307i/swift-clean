import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/services/domain/usecases/get_cart_items.dart';
import 'package:testing_firebase/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/services/domain/usecases/remove_from_cart.dart';
import 'package:testing_firebase/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/services/presentation/bloc/service_state.dart';

import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_services.dart';

class ServiceBloc extends Bloc<ServiceEvent,ServiceState>{
  final GetServices getServices;
  final GetItemByService getItemByService;

  ServiceBloc({
    required this.getServices,
    required this.getItemByService,
  }
      ) :super(ServiceInitial()){
    on<LoadServices>(_onLoadServices);
    on<LoadItemsByService>(_onLoadItemsByService);

  }

  Future<void> _onLoadServices(
      LoadServices event,
      Emitter<ServiceState> emit,
      ) async{
      emit(ServiceLoading());
      try{
        final services = await getServices.call();
        emit(ServiceLoaded(services));
      }catch(e){
        emit(ServiceError(e.toString()));
      }
  }

Future<void> _onLoadItemsByService(
    LoadItemsByService event,
    Emitter<ServiceState> emit,
    ) async{
      emit(ItemsLoading(event.serviceId));
      try{
        final result = await getItemByService(event.serviceId);
        emit(ItemsLoaded(event.serviceId,result));
      }catch(e){
        emit(ItemsError(e.toString()));
      }
    }
}