class UserDetailsEntity{
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? address;
  final String email;


  UserDetailsEntity({required this.id, required this.firstName, required this.lastName, required this.phoneNumber,required this.email, this.address});

}