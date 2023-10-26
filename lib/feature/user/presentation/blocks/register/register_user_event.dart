part of 'register_user_bloc.dart';

@immutable
abstract class RegisterUserEvent {}


class RegisterUserSubmitEvent extends RegisterUserEvent {
  final String name;
  final String last_name;
  final String phone_number;
  final String nick_name;
  final String email;
  final String password;

  RegisterUserSubmitEvent({
    required this.name,
    required this.last_name,
    required this.phone_number,
    required this.nick_name,
    required this.email,
    required this.password,
  });
}



