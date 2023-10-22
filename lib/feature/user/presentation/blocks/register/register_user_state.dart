part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class RegisterLoadingState extends RegisterUserState {}

class RegisterSuccessState extends RegisterUserState {}

class RegisterFailureState extends RegisterUserState {
  final String error;

  RegisterFailureState({required this.error});
}

class RedirectToRegistrationPage extends RegisterUserState {}