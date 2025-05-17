import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/services/domain/usecases/add_to_cart.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_cart_items.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/domain/usecases/remove_from_cart.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_event.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_state.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/features/services/presentation/widgets/service_item.dart';

import '../../domain/entites/item_entity.dart';
import '../../domain/entites/service_entity.dart';
import '../../dependency_injection.dart' as di;
import '../bloc/service_bloc.dart';
import '../bloc/service_state.dart';
import 'cart_page.dart';

class ItemsPage extends StatelessWidget{
  final String userId;
  final String serviceId;
  final String serviceName;

  const ItemsPage(this.userId, this.serviceId, this.serviceName);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => ServiceBloc(
              getServices: di.sl<GetServices>(),
              getItemByService: di.sl<GetItemByService>())..add(LoadItemsByService(serviceId)))
        ,
        BlocProvider(create: (context) => CartBloc(
            addToCart: di.sl<AddToCart>(),
            removeFromCart: di.sl<RemoveFromCart>(),
            getCartItems: di.sl<GetCartItems>())),
      ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(serviceName),
            actions: [
              IconButton(onPressed:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()
                    )
                );
              },icon: Icon(Icons.shopping_cart,color: Color(0xFF333E63)))

            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Color(0xFF333E63)),
              onPressed:() {
                Navigator.pop(context);
              },
            )
          ),
          body: ItemPage(userId: userId, serviceId: serviceId),
        ),
      );
  }

}

class ItemPage extends StatelessWidget {
  final String userId;
  final String serviceId;

  const ItemPage({Key? key, required this.userId ,required this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ServiceBloc,ServiceState>(
      listener: (context, state){
        if(state is ServiceError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state){
        if(state is ItemsLoading){
          return const Center(child: CircularProgressIndicator());
        }else if(state is ItemsLoaded){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      /*return ServiceItem(
                        onAddToCart: () {
                          print('Hello');
                        },
                        serviceName: state.items[index].name,
                        description: state.items[index].description,
                      );*/
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.ac_unit_rounded,color: Colors.black,),
                          Text(state.items[index].name),
                          IconButton(
                            onPressed: (){
                              context.read<CartBloc>().add(
                              AddItemToCart(userId,serviceId,state.items[index].id));
                            },
                            icon: Icon(Icons.add)),
                        ],
                      );
                    }
                    ),
              )
            ],
          );
        }
        return const Center(child: Text('Try Again Later'));
      },
    );

  }
}
