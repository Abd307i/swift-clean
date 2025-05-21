import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/notification/presentation/pages/NotificationsScreen.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_bloc.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_event.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_state.dart';
import 'package:testing_firebase/features/profile/presentation/pages/ProfileMenuScreen.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_event.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_state.dart';
import 'package:testing_firebase/features/profile/domain/usecases/get_profile_data.dart';
import '../../../order history/domain/entities/order_history.dart';
import '../../../order%20history/dependency_injection.dart' as di;
import '../../../profile/dependency_injection.dart' as profile_di;

class DrycleanerHomePage extends StatelessWidget {
  final String userId;

  const DrycleanerHomePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<OrderHistoryBloc>()
            ..add(GetOrderHistoryByUserType('Drycleaner', userId, 'In Progress')),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
              loadProfileData: profile_di.sl<LoadProfileData>())
            ..add(LoadProfileEvent(userId)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.profile.firstName} ${state.profile.lastName}',
                      style: TextStyle(
                        color: Color(0xFF333E63),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Welcome to SwiftClean Drycleaner :)',
                      style: TextStyle(
                        color: Color(0xFF7A5CF8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              } else {
                return Text(
                  'Drycleaner Dashboard',
                  style: TextStyle(
                    color: Color(0xFF333E63),
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(userId),
                    ),
                  );
                },
                child: Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF333E63),
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        body: DrycleanerHomePageContent(userId),
      ),
    );
  }
}

class DrycleanerHomePageContent extends StatefulWidget {
  final String userId;

  DrycleanerHomePageContent(this.userId);

  @override
  _DrycleanerHomePageContentState createState() => _DrycleanerHomePageContentState();
}

class _DrycleanerHomePageContentState extends State<DrycleanerHomePageContent> with SingleTickerProviderStateMixin {
  int _selectedIndex = 1; // Default to home page (middle icon)
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // Load different order types based on selected tab
      if (_tabController.indexIsChanging) {
        String status;
        switch (_tabController.index) {
          case 0:
            status = 'pending';
            break;
          case 1:
            status = 'processing';
            break;
          case 2:
            status = 'completed';
            break;
          default:
            status = 'pending';
        }

        context.read<OrderHistoryBloc>().add(
            GetOrderHistoryByUserType('drycleaner', widget.userId, status)
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              'Manage your laundry orders',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333E63),
              ),
            ),
          ),

          // Tab Bar for different order statuses
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF7A5CF8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[700],
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Processing'),
                Tab(text: 'Completed'),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Orders List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(),
                _buildOrdersList(),
                _buildOrdersList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == _selectedIndex) return;

            if (index == 0) {
              // Navigate to orders page
              // You can implement this later
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(widget.userId),
                ),
              );
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Color(0xFF333E63),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF7A5CF8),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.local_laundry_service,
                  color: Colors.white,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return BlocConsumer<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state) {
        if (state is OrderHistoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is OrderHistoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OrderHistoryLoaded) {
          if (state.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No orders available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return _buildOrderCard(order);
            },
          );
        } else {
          return Center(child: Text('Try Again Later'));
        }
      },
    );
  }

  Widget _buildOrderCard(OrderHistoryEntity order) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
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
                  'Order #${order.orderId.substring(0, 8)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333E63),
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            Divider(height: 24),
            Text(
              "Customer: ${order.customerId}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Items: ${order.items.length}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Total: \$${order.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333E63),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${_formatDate(order.createdAt!)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (order.status == 'pending')
                  Row(
                    children: [
                      _buildActionButton(
                        'Accept',
                        Colors.green,
                            () {
                          // Add logic to accept order
                        },
                      ),
                      SizedBox(width: 8),
                      _buildActionButton(
                        'Reject',
                        Colors.red,
                            () {
                          // Add logic to reject order
                        },
                      ),
                    ],
                  )
                else if (order.status == 'processing')
                  _buildActionButton(
                    'Mark as Ready',
                    Color(0xFF7A5CF8),
                        () {
                      // Add logic to mark as ready
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'processing':
        chipColor = Color(0xFF7A5CF8);
        break;
      case 'completed':
        chipColor = Colors.green;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(text),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}