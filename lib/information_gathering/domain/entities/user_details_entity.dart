class UserDetailsEntity{
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? address;

  UserDetailsEntity({required this.id, required this.firstName, required this.lastName, required this.phoneNumber, this.address});

}