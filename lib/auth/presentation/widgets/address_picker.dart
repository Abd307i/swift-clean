/*import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../domain/entites/adddress_entity.dart';

class AddressPicker extends StatefulWidget {
  final ValueChanged<AddressEntity> onAddressSelected;
  final _places = GoogleMapsPlaces(apiKey: 'YOUR_API_KEY_HERE');

  Future<void> _selectAddress(BuildContext context) async {
    final result = await showSearch<AddressEntity?>(
      context: context,
      delegate: AddressSearchDelegate(),
    );
    if (result != null) {
      onAddressSelected(result);
    }
  }

// ... Google Places API implementation
}*/