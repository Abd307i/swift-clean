import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/core/widgets/custom_button.dart';
import 'package:testing_firebase/features/services/domain/entites/item_entity.dart';
import 'package:testing_firebase/features/services/domain/entites/order_entity.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_event.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_state.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class ScheduleScreen extends StatefulWidget {
  final double totalPrice;
  final String customerId;
  final List<ItemEntity> items;
  final String? instructions;

  const ScheduleScreen({
    Key? key,
    required this.totalPrice,
    required this.customerId,
    required this.items,
    this.instructions,
  }) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState(totalPrice,customerId,items,instructions);
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<String> locations = ['Amman', 'Karak', 'Irbid', 'Zarqa'];
  String selectedLocation = 'Amman';

  final double totalPrice;
  final String customerId;
  final List<ItemEntity> items;
  final String? instructions;

  _ScheduleScreenState(this.totalPrice, this.customerId, this.items, this.instructions);

  late OrderBloc _orderBloc;

  // Selected date variables
  int selectedDay = DateTime.now().day;
  String selectedMonth = _getMonthName(DateTime.now().month);
  String selectedWeekday = _getWeekdayName(DateTime.now().weekday);

  // Selected time slot
  String selectedTimeSlot = '12:00 PM';

  // Generate the date options for display
  List<Map<String, dynamic>> dateOptions = [];

  @override
  void initState() {
    super.initState();
    // Get the OrderBloc instance from the dependency injection
    _orderBloc = GetIt.instance<OrderBloc>();
    _generateDateOptions();
  }

  @override
  void dispose() {
    // No need to close the bloc here as it's managed by GetIt
    super.dispose();
  }

  void _generateDateOptions() {
    final DateTime now = DateTime.now();
    dateOptions = List.generate(7, (index) {
      final DateTime date = now.add(Duration(days: index));
      return {
        'day': date.day,
        'month': _getMonthName(date.month),
        'weekday': _getWeekdayName(date.weekday),
      };
    });

    // Set initial selections to the current day
    selectedDay = dateOptions[0]['day'];
    selectedMonth = dateOptions[0]['month'];
    selectedWeekday = dateOptions[0]['weekday'];
  }

  static String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  static String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[(weekday - 1) % 7];
  }

  void _selectDate(int index) {
    setState(() {
      selectedDay = dateOptions[index]['day'];
      selectedMonth = dateOptions[index]['month'];
      selectedWeekday = dateOptions[index]['weekday'];
    });
  }

  void _selectTimeSlot(String timeSlot) {
    setState(() {
      selectedTimeSlot = timeSlot;
    });
  }

  void _proceedToPayment() {
    // Create a DateTime object for the selected date and time
    final DateTime now = DateTime.now();
    final int year = now.year;
    final int month = now.month; // Using current month for simplicity

    // Parse the time slot
    int hour = 12; // Default
    if (selectedTimeSlot.contains("AM")) {
      hour = int.parse(selectedTimeSlot.split(':')[0]);
      if (hour == 12) hour = 0; // 12 AM is 0 in 24-hour format
    } else if (selectedTimeSlot.contains("PM")) {
      hour = int.parse(selectedTimeSlot.split(':')[0]);
      if (hour != 12) hour += 12; // 12 PM stays as 12 in 24-hour format
    }

    final DateTime deliveryTime = DateTime(year, month, selectedDay, hour);

    // Create the order entity
    final orderEntity = OrderEntity(
        orderId: '11111',
        customerId: customerId,
        items: items.toList(),
        status: 'In Progress',
        totalPrice: totalPrice,
    );

    // Dispatch confirm order event
    _orderBloc.add(ConfirmOrderEvent(orderEntity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Your Schedule'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocProvider.value(
          value: _orderBloc,
          child: BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is OrderConfirmationLoaded) {
                // Navigate to success or payment screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order confirmed successfully!')),
                );
                // Navigate to payment screen or back to home
                // Navigator.pushReplacementNamed(context, '/payment');
              } else if (state is OrderError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pickup Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedLocation,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                            });
                          },
                          items: locations.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pickup Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 20),
                          onPressed: _generateDateOptions,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dateOptions.length,
                        itemBuilder: (context, index) {
                          final date = dateOptions[index];
                          final isSelected = date['day'] == selectedDay &&
                              date['month'] == selectedMonth &&
                              date['weekday'] == selectedWeekday;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => _selectDate(index),
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF6556FF) : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF6556FF) : Colors.grey.shade300,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      date['day'].toString().padLeft(2, '0'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      date['month'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected ? Colors.white : Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      date['weekday'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected ? Colors.white : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Time Slot',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 20),
                          onPressed: () {}, // Refresh time slots if needed
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildTimeSlot('09:00 AM'),
                          _buildTimeSlot('12:00 PM'),
                          _buildTimeSlot('02:00 PM'),
                          _buildTimeSlot('03:00 PM'),
                          _buildTimeSlot('04:00 PM'),
                        ],
                      ),
                    ),

                    const Spacer(),

                    CustomButton(
                      text: 'Proceed To Pay',
                      isLoading: state is OrderConfirmationLoading,
                      onPressed: _proceedToPayment,
                      backgroundColor: const Color(0xFF6556FF),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _buildTimeSlot(String time) {
    final bool isSelected = selectedTimeSlot == time;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => _selectTimeSlot(time),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6556FF) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF6556FF) : Colors.grey.shade300,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}