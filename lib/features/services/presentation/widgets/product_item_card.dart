import 'package:flutter/material.dart';

class ProductItemCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final double price;
  final Color iconBgColor;
  final int? initialQuantity;
  final Function onQuantityIncreased;
  final Function onQuantityDecreased;

  const ProductItemCard({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
    this.iconBgColor = const Color(0xFFE8F5F7), // Default light blue background
    this.initialQuantity = 0,
    required this.onQuantityIncreased,
    required this.onQuantityDecreased
  }) : super(key: key);

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity ?? 0;
  }

  void _decreaseQuantity() {
    widget.onQuantityDecreased;
  }

  void _increaseQuantity() {
    widget.onQuantityIncreased;
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
            ),
          ),
          const SizedBox(width: 16),
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: const TextStyle(
                    color: Color(0xFF333F65),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.price.toStringAsFixed(2)}',
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