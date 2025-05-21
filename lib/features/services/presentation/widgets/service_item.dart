import 'package:flutter/material.dart';
import 'service_item.dart';

class ServiceSelectionScreen extends StatelessWidget {
  const ServiceSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of available services
    final List<Map<String, dynamic>> services = [
      {
        'name': 'Dry Wash',
        'description': 'We provide the most advanced dry-cleaning services.',
        'imagePath': 'assets/dry_clean.png',
      },
      {
        'name': 'Washing & Folding',
        'description': 'Our service includes washing & folding just the way you like.',
        'imagePath': 'assets/wash_fold.png',
      },
      {
        'name': 'Ironing',
        'description': 'We care about your clothes most frequently all the time.',
        'imagePath': 'assets/iron.png',
      },
      {
        'name': 'Household Items',
        'description': 'Our equipment has the power to remove the toughest stains.',
        'imagePath': 'assets/household.png',
      },
      {
        'name': 'Socks Cleaning',
        'description': 'Bring your socks to us for shine, heel tip repair or sole replacement.',
        'imagePath': 'assets/socks.png',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333F65)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Choose Services',
          style: TextStyle(
            color: Color(0xFF333F65),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ServiceCard(
                      serviceName: service['name'],
                      description: service['description'],
                      imagePath: service['imagePath'],
                      onTap: () {
                        // Handle service selection
                        if (service['name'] == 'Washing & Folding') {
                          //here we should add the service item after we do it.
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${service['name']} service selected'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Schedule pickup action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Scheduling pickup...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Schedule A Pickup',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.description,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
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
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        color: Color(0xFF333F65),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      description,
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