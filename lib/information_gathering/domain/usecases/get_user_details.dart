import '../repositories/user_details_repository.dart';

class GetUserDetails{
  final UserDetailRepository repository;

  GetUserDetails(this.repository);

  Future<void> call(String userId) async{
    await repository.getUserDetails(userId);
  }

}