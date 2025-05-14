import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/services/domain/usecases/add_to_cart.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_cart_items.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/domain/usecases/remove_from_cart.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_state.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_event.dart';

import '../../domain/entites/item_entity.dart';
import '../../domain/entites/service_entity.dart';
import '../../dependency_injection.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_state.dart';
import 'cart_page.dart';

class ItemsPage extends StatelessWidget {
  final ServiceEntity service;

  const ItemsPage({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context)
    => ServiceBloc(getItemByService: sl<GetItemByService>(),
    getServices: sl<GetServices>()),
      child:
      Scaffold(
        appBar: AppBar(
          title: Text(service.name),
          actions: [
            IconButton(onPressed:() {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()
                  )
              );
            },icon: Icon(Icons.shopping_cart,color: Color(0xFF333E63)))

          ],
        ),
        body: BlocBuilder<ServiceBloc,ServiceState>(
          builder: (context, state) {

            if (state is ItemsLoading /*&& state.serviceId == service.id*/) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ItemsError) {
              return Center(child: Text('state.message'));
            }

            if (state is ItemsLoaded /*&& state.serviceId == service.id*/) {
              Text('Di');
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child:
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      //return Text(state.items[index].name);
                      return
                      ItemCard(item: state.items[index]);
                    },
                  )
                  )
                ],
              );
            }
            Text('Di');
            return const Center(child: Text('No items available'));
          },
        ),
      )
    );

  }
}

class ItemCard extends StatelessWidget {
  final ItemEntity item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: item.imgUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imgUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildPlaceholder(),
                ),
              )
                  : _buildPlaceholder(),
            ),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Up'),
                      Text('Down')
                    ],
                  )
                ]
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(Icons.shopping_bag, size: 30, color: Colors.grey),
    );
  }
}