part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {

  final String email;
  final String password;

  RegisterButtonPressed({required this.email, required this.password});
}
