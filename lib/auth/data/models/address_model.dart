import 'package:testing_firebase/auth/domain/entites/adddress_entity.dart';

class AddressModel extends AddressEntity{
  const AddressModel({
    super.street,
    super.city,
    super.postalCode,
    super.lat,
    super.lng,
});

  factory AddressModel.fromJson(Map<String, dynamic> json){
    return AddressModel(
        street: json['street'],
        city: json['city'],
        postalCode: json['postalCode'],
        lat: json['lat'],
        lng: json['lng']);
  }

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'postalCode': postalCode,
    'lat':lat,
    'lng':lng
  };
}