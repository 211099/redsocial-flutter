import 'package:actividad1c2/feature/user/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../data/datasources/user_api_data_source.dart';
import '../login/login_bloc.dart';
import '../../../data/datasources/user_api_data_source.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final UserApiDataSource userApiDataSource;
  final BuildContext context;

  RegisterUserBloc({required this.context})
      : userApiDataSource = UserApiDataSourceImp(context: context),
        super(RegisterUserInitial()) {
    on<RegisterUserSubmitEvent>((event, emit) async {
      // Accede a los datos del usuario del evento
      String name = event.name;
      String last_name = event.last_name;
      String phone_number = event.phone_number;
      String nick_name = event.nick_name;
      String email = event.email;
      String password = event.password;

      // Puedes imprimir los datos aquí
      print('Name: $name, Last Name: $last_name, Phone Number: $phone_number, Nick Name: $nick_name, Email: $email, Password: $password');
      if (event is RegisterUserSubmitEvent) {
        print('Email: ${event.email}, Password: ${event.password}');

        try {
          // Llama al método registerUser para registrar un nuevo usuario
          await userApiDataSource.registerUser(User(name: name,
              lastName: last_name,
              phoneNumber: phone_number,
              email: email,
              nickName: nick_name,
              password: password));
          // Tu lógica de registro aquí
          emit(RedirectToRegistrationPage());
        } catch (error) {
          // Maneja errores, por ejemplo, emite un estado de error
          emit(ErrorState(errorMessage: 'Error al registrar usuario: $error'));
        }
      }
    });
  }
}

class ErrorState extends RegisterUserState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
