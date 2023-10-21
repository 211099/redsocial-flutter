import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/datasources/user_api_data_source.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserApiDataSource userApiDataSource = UserApiDataSourceImp(); // Crea una instancia de UserApiDataSource

  RegisterBloc() : super(RegisterInitial()) {
    print('Se creó una instancia de RegisterBloc.');

    on<RegisterButtonPressed>((event, emit) async {
      print('Se llamó al evento RegisterButtonPressed.');

      if (event is RegisterButtonPressed) {
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
class ErrorState extends RegisterState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}



