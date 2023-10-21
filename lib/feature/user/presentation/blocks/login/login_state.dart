part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class IniciarSesionInitial extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
