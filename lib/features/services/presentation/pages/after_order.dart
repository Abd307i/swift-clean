import 'package:flutter/material.dart';
import 'package:testing_firebase/features/home%20page/Presentation/pages/Home%20Page%20User.dart';

import '../../../order history/presentation/pages/OrderHistoryModel.dart';

class AfterOrderScreen extends StatelessWidget {
  final String userId;
  final String orderNumber;

  const AfterOrderScreen({
    Key? key,
    required this.userId,
    required this.orderNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Order Review',
          style: TextStyle(
            color: Color(0xFF333E63),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF333E63)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image representing order confirmation
                  Image.asset(
                    'assets/booked 1.png',
                    height: 220,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 24),

                  // Success message
                  Text(
                    'Successfully booked!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333E63),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Order details message
                  Text(
                    'We are preparing your order #$orderNumber. You will receive a notification once the Laundry shop confirms.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Track Order button
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to order tracking page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderTrackingPage(userId: userId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D3A59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Track Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Back To Home button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(userId: userId),
                    ),
                        (route) => false, // Clear the navigation stack
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7A5CF8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Back To Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order Tracking Page using the OrderHistoryModel
class OrderTrackingPage extends StatelessWidget {
  final String userId;

  const OrderTrackingPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get sample orders from the model
    final orders = OrderHistoryModel.getOrders();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Color(0xFF333E63),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF333E63)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderHistoryModel order) {
    Color statusColor;
    IconData statusIcon;

    // Set color and icon based on status
    switch (order.status) {
      case 'Delivered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'In Progress':
        statusColor = Colors.orange;
        statusIcon = Icons.timelapse;
        break;
      case 'Canceled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.circle;
    }

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderNumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF333E63),
                  ),
                ),
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      order.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              order.dateTime,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.numberOfItems} items',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '\$${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333E63),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}