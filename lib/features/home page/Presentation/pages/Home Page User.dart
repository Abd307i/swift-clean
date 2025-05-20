import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/home%20page/Presentation/widgets/home_widgets.dart';
import 'package:testing_firebase/features/notification/presentation/pages/NotificationsScreen.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/features/services/presentation/pages/items_page.dart';
import 'package:testing_firebase/features/services/dependency_injection.dart' as di;
import 'package:testing_firebase/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_event.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_state.dart';
import 'package:testing_firebase/features/profile/domain/usecases/get_profile_data.dart';
import '../../../profile/presentation/pages/ProfileMenuScreen.dart';
import '../../../services/presentation/bloc/service_state.dart';
import '../../../services/presentation/pages/service_page.dart';
import '../../../profile/dependency_injection.dart' as profile_di;

class HomePage extends StatelessWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ServiceBloc(
                getServices: di.sl<GetServices>(),
                getItemByService: di.sl<GetItemByService>()
            )..add(LoadServices()),
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
                        'Welcome to SwiftClean :)',
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
                    'Welcome',
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
          body: HomePageState(userId),
        )
    );
  }

}

class HomePageState extends StatelessWidget {
  final String userId;
  HomePageState(this.userId);

  int _selectedIndex = 1; // Default to home page (middle icon)

  @override
  Widget build(BuildContext context) {

    Widget _buildServiceCard(String serviceName, String serviceId, String imagePath) {
      return ServiceCardWidget(
        title: serviceName,
        imagePath: imagePath,
        onTap: () {
          // Navigate to service details when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemsPage(userId,serviceId ,serviceName),
            ),
          );
        },
      );
    }

    return BlocConsumer<ServiceBloc, ServiceState>(
      listener: (context,state){
        if(state is ServiceError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state){
        if(state is ServiceLoading){
          return const Center(child: CircularProgressIndicator());
        }else if(state is ServiceLoaded){
          print(state.services.length);
          //return Text(state.services.length.toString());
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [
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
                SizedBox(height: 24),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(left: 16.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.services.length,
                        itemBuilder: (context,index) {
                          return _buildServiceCard(state.services[index].name, state.services[index].id ,'assets/d w 1.png');
                        }
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/Home Page.png',
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 16),
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
                onTap: (index){
                  if (index == _selectedIndex) return;

                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesPage(userId: userId),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(userId),
                      ),
                    );
                  } else {
                    _selectedIndex = index;
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
        }else{
          return const Center(child: Text('Try Again Later'));
        }
      },
    );
  }
}