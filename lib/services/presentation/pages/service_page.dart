import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/service_bloc.dart';
import '../bloc/service_event.dart';
import '../bloc/service_state.dart';
import '../widgets/service_item.dart';

class ServicePage extends StatelessWidget{
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخدمات المتاحة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart page
            },
          ),
        ],
      ),
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServiceError) {
            return Center(child: Text(state.message));
          } else if (state is ServiceLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return ServiceItem(
                  service: service,
                  onAddToCart: () {
                    // Implement add to cart functionality
                  },
                );
              },
            );
          }
          return const Center(child: Text('لا توجد خدمات متاحة حالياً'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ServiceBloc>().add(LoadServices());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}