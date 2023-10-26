part of 'login_bloc.dart';

@immutable
abstract class RegisterEvent {}

class LoginButtonPressed extends RegisterEvent {

  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}
