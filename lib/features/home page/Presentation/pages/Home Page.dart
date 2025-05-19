import 'package:flutter/material.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/home%20page/Presentation/widgets/home_widgets.dart';
import 'package:testing_firebase/features/notification/presentation/pages/NotificationsScreen.dart';
import 'package:testing_firebase/features/profile/presentation/pages/ProfileMenuScreen.dart';
import 'package:testing_firebase/features/services/presentation/pages/service_page.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to home page (middle icon)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(widget.userId),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Text(
                'Which laundry service do\nyou need today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333E63),
                ),
              ),
            ),

            // Service Selection Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildServiceCard('Dry Wash', 'assets/d w 1.png', 0),
                  _buildServiceCard('Socks', 'assets/socks 1.png', 1),
                  _buildServiceCard('Ironing', 'assets/iron 2 1.png', 2),
                  _buildServiceCard('Household\nItems', 'assets/wash fold 1.png', 3),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Main Image
            Center(
              child: Image.asset(
                'assets/Home Page.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 16),

            // Service List
          ],
        ),
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
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Color(0xFF333E63),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'assignment',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF7A5CF8),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.home,
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

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServicesPage(userId: widget.userId),
        ),
      );
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
  }

  Widget _buildServiceCard(String title, String imagePath, int index) {
    return ServiceCardWidget(
      title: title,
      imagePath: imagePath,
      onTap: () {
        // Navigate to service details when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicesPage(userId: widget.userId),
          ),
        );
      },
    );
  }

  Widget _buildServiceListItem(String title, String description, String imagePath) {
    return ServiceListItemWidget(
      title: title,
      description: description,
      imagePath: imagePath,
      onTap: () {
        // Navigate to specific service details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicesPage(userId: widget.userId),
          ),
        );
      },
    );
  }
}