import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/services/presentation/bloc/service_state.dart';

import '../../domain/usecases/get_services.dart';

class ServiceBloc extends Bloc<ServiceEvent,ServiceState>{
  final GetServices getServices;
  ServiceBloc(this.getServices):super(ServiceInitial()){
    on<LoadServices>((event,emit) async{
      emit(ServiceLoading());
      try{
        final services = await getServices();
        emit(ServiceLoaded(services));
      }catch(e){
        emit(ServiceError(e.toString()));
      }
    });
  }

}