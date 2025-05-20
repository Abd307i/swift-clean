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

import '../../domain/entites/item_entity.dart';
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
            getCartTotalPrice: di.sl<GetCartTotalPrice>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              serviceName,
              style: const TextStyle(
                color: Color(0xFF333F65),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed:() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen(userId)
                        )
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, color: Color(0xFF333E63))
              )
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF333E63)),
              onPressed:() {
                Navigator.pop(context);
              },
            )
        ),
        body: ItemPage(userId: userId, serviceName: serviceName),
        bottomNavigationBar: _AddToCartButton(userId: userId, serviceId: serviceId),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final String userId;
  final String serviceId;

  const _AddToCartButton({
    Key? key,
    required this.userId,
    required this.serviceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          bool hasSelectedItems = false;
          List<ItemEntity> selectedItems = [];

          if (state is ItemsLoaded) {
            // Check if any item has quantity > 0
            final productsWithQuantity = state.items.where((item) {
              final productCardState = context.findAncestorStateOfType<_ProductItemCardState>();
              return productCardState != null && productCardState.quantity > 0;
            }).toList();

            hasSelectedItems = productsWithQuantity.isNotEmpty;
            selectedItems = productsWithQuantity;
          }

          return CustomButton(
            text: 'Add to Cart',
            onPressed: () {
              // Get all selected items and add them to cart
              final cartBloc = context.read<CartBloc>();

              // Loop through all ProductItemCard widgets to get quantities
              // This is managed by the individual ProductItemCard states
              // Navigation to cart page can happen after adding items
              if (hasSelectedItems) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Items added to cart!')),
                );

                // After adding items, navigate to cart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen(userId)),
                );
              } else {
                // Show message if no items selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select items to add to cart')),
                );
              }
            },
            height: 50.0,
            borderRadius: 12.0,
            backgroundColor: const Color(0xFF6C63FF),
            textColor: Colors.white,
          );
        },
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  final String userId;
  final String serviceName;

  const ItemPage({Key? key, required this.userId, required this.serviceName}) : super(key: key);

  // Function to map item names to image paths
  String _getItemImagePath(String itemName) {
    // Converting to lowercase for case-insensitive comparison
    switch (itemName.toLowerCase()) {
      case 'hoodie':
        return 'assets/images/hoodi.png';
      case 't-shirt':
        return 'assets/images/T-shirt.png';
      case 'coat':
        return 'assets/images/coat.png';
      case 'jeans pant':
        return 'assets/images/jeans pant.png';
      case 'short pant':
        return 'assets/images/short pant.png';
      case 'sweater':
        return 'assets/images/sweater.png';
      case 'boxer':
        return 'assets/images/boxer.png';
      default:
        return 'assets/images/cleaning.png'; // Default icon
    }
  }

  // Function to get a background color based on the item index
  Color _getBackgroundColor(int index) {
    final List<Color> colors = [
      const Color(0xFFE8F5F7), // Light blue
      const Color(0xFFFFF8E7), // Light yellow
      const Color(0xFFF3EEFB), // Light purple
      const Color(0xFFFEEFEF), // Light red
      const Color(0xFFE8FEF0), // Light green
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is ServiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ItemsLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ProductItemCard(
                  item: item,
                  userId: userId,
                  serviceId: state.serviceId,
                  iconBgColor: _getBackgroundColor(index),
                  imagePath: _getItemImagePath(item.itemName),
                ),
              );
            },
          );
        }
        return const Center(child: Text('No items available'));
      },
    );
  }
}

class ProductItemCard extends StatefulWidget {
  final ItemEntity item;
  final String userId;
  final String serviceId;
  final String imagePath;
  final Color iconBgColor;

  const ProductItemCard({
    Key? key,
    required this.item,
    required this.userId,
    required this.serviceId,
    required this.imagePath,
    this.iconBgColor = const Color(0xFFE8F5F7),
  }) : super(key: key);

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  int quantity = 0;

  void _decreaseQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });

      // Remove item from cart when decreasing quantity
      if (quantity == 0) {
        context.read<CartBloc>().add(
          RemoveItemFromCart(
            widget.userId,
            widget.serviceId,
            widget.item.itemId,
          ),
        );
      }
    }
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });

    // Add item to cart when increasing quantity
    if (quantity == 1) {
      context.read<CartBloc>().add(
        AddItemToCart(
          widget.userId,
          widget.serviceId,
          widget.item.itemId,
          widget.item.itemName,
          widget.item.subPrice,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: widget.iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.cleaning_services,
                  color: Color(0xFF6C63FF),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.itemName,
                  style: const TextStyle(
                    color: Color(0xFF333F65),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.item.subPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF629BFC),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.item.description != null && widget.item.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      widget.item.description!,
                      style: const TextStyle(
                        color: Color(0xFF8E9AAF),
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                onTap: _decreaseQuantity,
              ),
              // Quantity display
              Container(
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333F65),
                  ),
                ),
              ),
              // Increase button
              _buildQuantityButton(
                icon: Icons.add,
                onTap: _increaseQuantity,
              ),
            ],
          ),
        ],
      ),
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