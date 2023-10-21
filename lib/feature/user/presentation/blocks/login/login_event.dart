part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}


class onIniciar extends LoginEvent{
  final String email;
  final String password;

  onIniciar({required this.password, required this.email});
}