import 'package:flutter/material.dart';
import 'package:testing_firebase/features/order%20history/domain/entities/order_history.dart';
import '../../../../core/constants/PickColorHelper.dart';
import 'OrderHistoryModel.dart';


class OrderTrackingScreen extends StatefulWidget {
  final OrderHistoryEntity order;
  const OrderTrackingScreen({Key? key, required this.order}) : super(key: key);

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState(order);
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int currentStep = 2;
  final OrderHistoryEntity order;
  _OrderTrackingScreenState(this.order);


  List<StepData> steps = [
    StepData(title: 'Order Placed', subtitle: 'Your order has been placed', isCompleted: true),
    StepData(title: 'Preparing', subtitle: 'Your order is being prepared', isCompleted: true),
    StepData(title: 'On the Way', subtitle: 'Your order is on its way', isCompleted: false),
    StepData(title: 'Delivered', subtitle: 'Your order has been delivered', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      appBar: AppBar(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        title: Text(
          'Track Order #${order.orderId}',
          style: TextStyle(
            color: ColorPickerHelper.colorHelper('mainTextColor'),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorPickerHelper.colorHelper('mainTextColor'),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderInfoCard(order: order),
            const SizedBox(height: 20),
            DeliveryTimeline(steps: steps, currentStep: currentStep),
            const SizedBox(height: 20),
            DeliveryAddressCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class StepData {
  final String title;
  final String subtitle;
  final bool isCompleted;

  StepData({
    required this.title,
    required this.subtitle,
    required this.isCompleted
  });
}

class DeliveryTimeline extends StatelessWidget {
  final List<StepData> steps;
  final int currentStep;

  const DeliveryTimeline({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final isLast = index == steps.length - 1;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: index <= currentStep ? Colors.blue : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              index <= currentStep ? Icons.check : null,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 50,
                            color: index < currentStep ? Colors.blue : Colors.grey.shade300,
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            steps[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: index <= currentStep ? Colors.blue : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[index].subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: isLast ? 0 : 30),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderInfoCard extends StatelessWidget {
  final OrderHistoryEntity order;
  const OrderInfoCard({Key? key, required this.order,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$ ${order.totalPrice}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              order.lastUpdate.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Ali Dweik',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            const Text(
              'Amman',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Phone: +962 780680780',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}