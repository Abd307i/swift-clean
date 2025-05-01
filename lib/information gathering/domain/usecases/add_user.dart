import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/information%20gathering/domain/repositories/user_details_repository.dart';

class AddUser{
  final UserDetailRepository repository;

  AddUser(this.repository);

  Future<void> call(UserEntity user) async{
    await repository.addUser(user);
  }

}