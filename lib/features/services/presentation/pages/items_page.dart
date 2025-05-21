import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/core/widgets/custom_button.dart';
import 'package:testing_firebase/features/services/domain/usecases/add_to_cart.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_cart_items.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/domain/usecases/remove_from_cart.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_event.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_state.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/features/services/presentation/widgets/product_item_card.dart';
import 'package:testing_firebase/features/services/presentation/widgets/service_item.dart';

import '../../domain/entites/item_entity.dart';
import '../../domain/entites/service_entity.dart';
import '../../dependency_injection.dart' as di;
import '../../domain/usecases/get_cart_totalprice.dart';
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
            getCartItems: di.sl<GetCartItems>(),
            getCartTotalPrice: di.sl<GetCartTotalPrice>())..add(LoadCartItems(userId)),
        ),
      ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(serviceName),
            actions: [
              IconButton(onPressed:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen(userId)
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
          body: ItemPage(userId: userId, serviceName: serviceName, serviceId:serviceId),
        ),
      );
  }

}

class ItemPage extends StatelessWidget {
  final String userId;
  final String serviceName;
  final String serviceId;
  const ItemPage({Key? key, required this.userId ,required this.serviceName, required this.serviceId}) : super(key: key);

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
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product image with colored background
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/hoodi.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Product info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.items[index].itemName,
                                    style: const TextStyle(
                                      color: Color(0xFF333F65),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${state.items[index].subPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFF629BFC),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity controls
                            Row(
                              children: [
                                // Decrease button
                                _buildQuantityButton(
                                  icon: Icons.remove,
                                  onTap: (){
                                    context.read<CartBloc>().add(RemoveItemFromCart(userId,serviceId,state.items[index].itemName));
                                  },
                                ),


                                // Quantity display
                                BlocBuilder<CartBloc,CartState>(
                                  buildWhen: (prev,cur)=>cur is CartLoaded ,
                                  builder: (context, state) {

                                    if(state is CartLoaded){
                                      return Container(
                                        width: 30,
                                        alignment: Alignment.center,
                                        child: Text(
                                          (state.items[index].count??0).toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF333F65),
                                          ),
                                        ),
                                      );
                                    }
                                    return Text('');
                                  }
                                ),
                                // Increase button
                                _buildQuantityButton(
                                  icon: Icons.add,
                                  onTap: (){
                                    context.read<CartBloc>().add(
                                        AddItemToCart(userId,
                                            state.serviceId,
                                            state.items[index].itemId,
                                            state.items[index].itemName,
                                            state.items[index].subPrice
                                        )
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );

                    }),
              )
            ],
          );
        }
        return const Center(child: Text('Try Again Later'));
      },
    );

  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16,
            color: const Color(0xFF9CA4AB),
          ),
        ),
      ),
    );
  }
}
