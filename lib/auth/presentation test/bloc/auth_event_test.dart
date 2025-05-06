import 'package:equatable/equatable.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

abstract class AuthEventTest extends Equatable{
  const AuthEventTest();
  @override
  List <Object?> get props => [];
}

class LoginEventTest extends AuthEventTest{
  final String email;
  final String password;

  const LoginEventTest({required this.email, required this.password});

  @override
  List<Object> get props => [email,password];
}

class RegisterEventTest extends AuthEventTest{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? address;

  const RegisterEventTest({required this.email, required this.password, required this.firstName, required this.lastName
  , required this.phoneNumber, this.address});

  @override
  List<Object> get props => [email,password,firstName,lastName,phoneNumber];
}

class ForgotPasswordEventTest extends AuthEventTest {
  final String email;

  const ForgotPasswordEventTest({required this.email});

  @override
  List<Object> get props => [email];
}

class UserChangedEventTest extends AuthEventTest {
  final UserEntity? user;

  const UserChangedEventTest(this.user);

  @override
  List<Object?> get props => [user];
}

class LogoutEventTest extends AuthEventTest {}