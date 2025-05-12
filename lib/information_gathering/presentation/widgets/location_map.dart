/*mport 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;
  final CameraPosition initialPosition;
  final Set<Marker> markers;
  final Function(LatLng) onTap;
  final bool isPermissionDenied;

  const LocationMap({
    Key? key,
    required this.onMapCreated,
    required this.initialPosition,
    required this.markers,
    required this.onTap,
    this.isPermissionDenied = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: isPermissionDenied
            ? const Center(
          child: Text(
            'Location permission denied.\nPlease enable location permissions in settings.',
            textAlign: TextAlign.center,
          ),
        )
            : GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: initialPosition,
          markers: markers,
          onTap: onTap,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
        ),
      ),
    );
  }
}*/