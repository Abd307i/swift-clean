import 'package:testing_firebase/auth/domain/entites/adddress_entity.dart';

abstract class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final AddressEntity? address;
  final bool emailVerified;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.address,
    this.emailVerified = false,
});
}