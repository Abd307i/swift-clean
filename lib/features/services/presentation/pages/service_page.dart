import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/presentation/pages/cart_page.dart';
import '../../dependency_injection.dart' as di;
import '../../domain/entites/service_entity.dart';
import '../bloc/service_bloc.dart';
import '../bloc/service_event.dart';
import '../bloc/service_state.dart';
import 'items_page.dart';

class ServicesPage extends StatelessWidget {
  final String userId;

  const ServicesPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc(
          getServices: di.sl<GetServices>(),
          getItemByService: di.sl<GetItemByService>())..add(LoadServices()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Choose Services',
            style: TextStyle(
              color: Color(0xFF333F65),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF333F65)),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen(userId)),
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Color(0xFF333F65)),
            ),
          ],
        ),
        body: ServicesListView(userId: userId),
      ),
    );
  }
}

class ServicesListView extends StatelessWidget {
  final String userId;
  const ServicesListView({Key? key, required this.userId}) : super(key: key);

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
        if (state is ServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ServiceLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ServiceCardItem(
                    service: service,
                    userId: userId,
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: Text('No services available'));
      },
    );
  }
}

class ServiceCardItem extends StatelessWidget {
  final ServiceEntity service;
  final String userId;

  const ServiceCardItem({
    Key? key,
    required this.service,
    required this.userId,
  }) : super(key: key);

  // Function to get icon path based on service name
  String _getIconPath(String serviceName) {
    // Converting to lowercase for case-insensitive comparison
    switch (serviceName.toLowerCase()) {
      case 'dry wash':
        return 'assets/images/cleaning 1.png';
      case 'washing & folding':
        return 'assets/images/d w 1.png';
      case 'ironing':
        return 'assets/images/iron.png';
      case 'household items':
        return 'assets/images/wash fold 1.png';
      case 'socks cleaning':
        return 'assets/images/socks.png';
      default:
        return 'assets/images/cleaning.png'; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    String iconPath = _getIconPath(service.name);

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemsPage(
                userId,
                service.id,
                service.name,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F2F9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback icon if image loading fails
                      return const Icon(
                        Icons.cleaning_services,
                        color: Color(0xFF6C63FF),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        color: Color(0xFF333F65),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      service.description,
                      style: const TextStyle(
                        color: Color(0xFF8E9AAF),
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}