import 'package:testing_firebase/features/auth/domain/entites/adddress_entity.dart';

abstract class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final AddressEntity? address;
  final bool emailVerified;
  final String userType;
  final bool? verified;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    required this.verified,
    this.address,
    this.emailVerified = false,
});
}