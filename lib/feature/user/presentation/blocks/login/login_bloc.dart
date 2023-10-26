import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../data/datasources/user_api_data_source.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<RegisterEvent, LoginState> {
  final UserApiDataSource userApiDataSource;
  final BuildContext context;

  LoginBloc({required this.context})
      : userApiDataSource = UserApiDataSourceImp(context: context),
        super(LoginInitial()) {
    print('Se creó una instancia de RegisterBloc.');
    on<LoginButtonPressed>((event, emit) async {
      print('Se llamó al evento RegisterButtonPressed.');

      if (event is LoginButtonPressed) {
        print('Email: ${event.email}, Password: ${event.password}');

        try {
          // Llama al método logIn para iniciar sesión
          await userApiDataSource.logIn(email: event.email, password: event.password);

          // Tu lógica de registro aquí
          emit(RedirectToRegistrationPage());
        } catch (error) {
          // Maneja errores, por ejemplo, emite un estado de error
          emit(ErrorState(errorMessage: 'Error al iniciar sesiónssssss: $error'));
        }
      }
    });
  }
}
class ErrorState extends LoginState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}



