abstract class UserEntity {
  final String id;
  final String email;
  final String? name;
  final bool emailVerified;

  const UserEntity({required this.id, required this.email, this.name,required this.emailVerified});
}