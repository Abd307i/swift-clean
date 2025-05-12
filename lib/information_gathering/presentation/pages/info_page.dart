/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:testing_firebase/information_gathering/domain/entities/user_details_entity.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
// Import custom widgets
import '../widgets/custom_text_field.dart';
import '../widgets/location_map.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_title.dart';
import '../widgets/custom_app_bar.dart';

class InformationGatheringScreen extends StatefulWidget {
  const InformationGatheringScreen({Key? key}) : super(key: key);

  @override
  _InformationGatheringScreenState createState() => _InformationGatheringScreenState();
}

class _InformationGatheringScreenState extends State<InformationGatheringScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Location variables
  GoogleMapController? _mapController;
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962), // Default position (will be updated)
    zoom: 14.0,
  );
  final Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  bool _isLoading = true;
  bool _locationPermissionDenied = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    final PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      _getCurrentLocation();
    } else {
      setState(() {
        _isLoading = false;
        _locationPermissionDenied = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied')),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        );
        _isLoading = false;
      });

      // If the map controller is ready, move the camera
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
      }
    } catch (e) {
      print('Error getting current location: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a location on the map')),
        );
        return;
      }

      try {
        setState(() {
          _isSubmitting = true;
        });

        // Create user details entity
        final userDetails = UserDetailsEntity(
          id: const Uuid().v4(), // Generate a unique ID
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneNumberController.text,
          address: _addressController.text,
        );

        // Here you would typically send the entity to your repository
        // This is where you'd connect to your use cases
        // Example: final result = await addUserDetails(userDetails);

        print('User details to save: ${userDetails.firstName} ${userDetails.lastName}, ${userDetails.phoneNumber}, ${userDetails.address}');

        setState(() {
          _isSubmitting = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User details saved successfully')),
        );

        // Optionally navigate back or to another screen
        // Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          _isSubmitting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user details: $e')),
        );
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });

    // Move camera to initial position if it's already determined
    if (!_isLoading) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
    }
  }

  Future<void> _onMapTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${location.latitude}, ${location.longitude}',
          ),
        ),
      );
    });

    // Perform reverse geocoding to get address
    await _getAddressFromLatLng(location);
  }

  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = [
          place.street,
          place.subLocality,
          place.locality,
          place.postalCode,
          place.country,
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        setState(() {
          _addressController.text = address;
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get address from location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Information'),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionTitle(
                    title: 'Please provide your details below.',
                    bottomPadding: 32,
                  ),
                  CustomTextField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const SectionTitle(title: 'Select your location:'),
                  LocationMap(
                    onMapCreated: _onMapCreated,
                    initialPosition: _initialPosition,
                    markers: _markers,
                    onTap: _onMapTap,
                    isPermissionDenied: _locationPermissionDenied,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _addressController,
                    labelText: 'Address',
                    isMultiline: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location on the map or enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    text: 'Save Details',
                    onPressed: _submitForm,
                    isLoading: _isSubmitting,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/