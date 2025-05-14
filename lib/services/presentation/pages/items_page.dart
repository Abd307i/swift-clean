import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entites/item_entity.dart';
import '../../domain/entites/service_entity.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_state.dart';

class ItemsPage extends StatelessWidget {
  final ServiceEntity service;

  const ItemsPage({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
      ),
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ItemsLoading && state.serviceId == service.id) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ItemsError) {
            return Center(child: Text(state.message));
          }

          if (state is ItemsLoaded && state.serviceId == service.id) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return ItemCard(item: state.items[index]);
              },
            );
          }

          return const Center(child: Text('No items available'));
        },
      ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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