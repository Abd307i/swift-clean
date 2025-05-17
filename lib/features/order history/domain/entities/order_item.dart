class OrderItem {
  final String id;
  final String name;
  final String serviceType;
  final double price;
  final int quantity;
  final String? specialInstructions;

  OrderItem({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.price,
    required this.quantity,
    this.specialInstructions,
  });
}