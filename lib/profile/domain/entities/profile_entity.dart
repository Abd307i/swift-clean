class ProfileEntity{
  final String userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String? imgUrl;
  final String? address;

  const ProfileEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.imgUrl,
    this.address
});
}