class OrderHistoryModel {
  final String orderNumber;
  final String dateTime;
  final String status;
  final int numberOfItems;
  final double price;

  OrderHistoryModel({
    required this.orderNumber,
    required this.dateTime,
    required this.status,
    required this.numberOfItems,
    required this.price,
  });

  // Static method to generate sample orders
  static List<OrderHistoryModel> getOrders() {
    return [
      OrderHistoryModel(
        orderNumber: '841565',
        dateTime: '11 Mar 2021 at 06:00 PM',
        status: 'Delivered',
        numberOfItems: 20,
        price: 230,
      ),
      OrderHistoryModel(
        orderNumber: '356515',
        dateTime: '02 Mar 2021 at 11:00 AM',
        status: 'Delivered',
        numberOfItems: 6,
        price: 110,
      ),
      OrderHistoryModel(
        orderNumber: '8156214',
        dateTime: '25 Feb 2021 at 12:00 AM',
        status: 'Canceled',
        numberOfItems: 3,
        price: 40,
      ),
      OrderHistoryModel(
        orderNumber: '656214',
        dateTime: '25 Feb 2021 at 12:00 AM',
        status: 'Delivered',
        numberOfItems: 3,
        price: 60,
      ),
      OrderHistoryModel(
        orderNumber: '654565',
        dateTime: '11 Mar 2021 at 10:00 AM',
        status: 'In Progress',
        numberOfItems: 12,
        price: 130,
      ),
    ];
  }
}